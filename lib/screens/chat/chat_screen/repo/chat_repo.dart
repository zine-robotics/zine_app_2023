import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/api.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../models/rooms.dart';
import '../../../../models/user.dart';


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

  Future<String?> getRoomName(String groupID) {
    return _firebaseFirestore
        .collection('rooms')
        .where('id', isEqualTo: groupID)
        .limit(1) // Assuming there is only one group with the given name
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
    });
  }

  dynamic getRoomData(String groupID) {
    return _firebaseFirestore
        .collection('rooms')
        .doc(groupID)
        .get()
        .then((querySnapshot) {
      return querySnapshot.data();
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

  Future<UserModel?> getUserDetailsByID(String uid) async{
    var user = await _firebaseFirestore.collection('users').doc(uid).get();
    UserModel userMod = UserModel(
      uid: user['uid'],
      email: user['email'],
      name: user['name'],
      dp: user['dp'],
      type: user['type'],
      // registered: user['registered'],
      // tasks: tasks,
      // rooms: user['rooms'],
      // roomIDs: user['roomids'],
      // roomDetails: map,
      // lastSeen: user.data()!['lastSeen'] != null ? user['lastSeen'] : {});
    );
    return userMod;
  }


  // dynamic getLastChat(String roomId) async {
  //   String? groupChatId = roomId;
  //
  //   var data = await _firebaseFirestore
  //       .collection('rooms')
  //       .doc(groupChatId.toString())
  //       .collection('messages')
  //       .orderBy('timeStamp', descending: true)
  //       .limit(1)
  //       .get();
  //
  //   if (data.docs != null && data.docs.length > 0) {
  //     return MessageModel.store(data.docs[0]).timeStamp as Timestamp;
  //   } else
  //     return null;
  // }

  dynamic getRooms(String groupChatId) async{
    var data= await   _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupChatId)
        .limit(1).get();
    if (data.docs != null && data.docs.length > 0) {
      return Rooms.store(data.docs[0]);
    } else
      return null;
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
      dynamic reply,
  ) async {
    String? groupId = await getRoomId(roomName);
    groupId = groupId.toString();
    DocumentReference documentReference = _firebaseFirestore
        .collection('rooms')
        .doc(groupId)
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    // print(reply);
    MessageModel messageChat = MessageModel(
        from: from,
        group: groupId,
        message: message,
        replyTo: reply?.toJson(),
        timeStamp: Timestamp.now()
    );

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
