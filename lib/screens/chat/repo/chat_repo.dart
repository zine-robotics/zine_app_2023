import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/api.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatRepo {
  // final SharedPreferences prefs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  List<MessageModel> chats = [];
  // ChatProvider();

  // String? getPref(String key) {
  //   return prefs.getString(key);
  // }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return _firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Future<String?> getRoomId(String groupName) {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupName)
        .limit(1) // Assuming there is only one group with the given name
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
    });
  }

  dynamic getChatStream(String groupName) async {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupName)
        .limit(1) // Assuming there is only one group with the given name
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final groupChatId = querySnapshot.docs.first.id;
        return _firebaseFirestore
            .collection('rooms')
            .doc(groupChatId)
            .collection('messages')
            .orderBy('timeStamp')
            .snapshots();
      } else {
        throw Exception('No matching documents');
      }
    });
  }

  dynamic getLastChat(String roomName) async {
    String? groupChatId = await getRoomId(roomName);
    // print(groupChatId.toString());
    var data = await _firebaseFirestore
        .collection('rooms')
        .doc(groupChatId.toString())
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .limit(1)
        .get();

    if (data.docs != null && data.docs.length > 0) {
      return MessageModel.store(data.docs[0]).timeStamp as Timestamp;
    } else
      return null;
  }

  Query<Map<String, dynamic>> getRooms(String groupChatId) {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupChatId);
    // .get();
    // chats = List.from(data.docs.map((doc) => MessageModel.store(doc)));
    // .limit(limit)
  }

  void updateLastSeen(var user, var room) async {
    await _firebaseFirestore
        .collection("users")
        .where("email", isEqualTo: user)
        .get()
        .then((value) => value.docs[0].reference.set({
              "lastSeen": {room: Timestamp.fromDate(DateTime.now())}
            }, SetOptions(merge: true)));
  }

  void sendMessage(
    String from,
    String roomName,
    String message,
  ) async {
    String? groupId = await getRoomId(roomName);
    groupId = groupId.toString();
    DocumentReference documentReference = _firebaseFirestore
        .collection('rooms')
        .doc(groupId)
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageModel messageChat = MessageModel(
        from: from,
        group: groupId,
        message: message,
        timeStamp: Timestamp.now());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
    sendFCMMessage(roomName, from, message);
  }

  Future<String> uploadImageToFirebase(dynamic image) async {
    Reference storageReference = _firebaseStorage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final UploadTask uploadTask = storageReference.putFile(image);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url =
        (await downloadUrl.ref.getDownloadURL().catchError((e) => {null}));

    return url;
  }
}
