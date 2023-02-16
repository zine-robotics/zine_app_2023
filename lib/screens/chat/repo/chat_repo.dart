import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/api.dart';
import 'package:zineapp2023/models/message.dart';

class ChatRepo {
  // final SharedPreferences prefs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(
      String groupChatId) {
    return _firebaseFirestore
        .collection('rooms')
        .doc(groupChatId)
        .collection('messages')
        .snapshots();
    // .get();
    // chats = List.from(data.docs.map((doc) => MessageModel.store(doc)));
    // .limit(limit)
  }

  Future<MessageModel> getLastChat(String groupChatId) async {
    var data = await _firebaseFirestore
        .collection('rooms')
        .doc(groupChatId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .limit(1)
        .get();
    var lastChat;
    return lastChat = MessageModel.store(data.docs[0]);
  }

  Query<Map<String, dynamic>> getRooms(String groupChatId) {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupChatId);
    // .get();
    // chats = List.from(data.docs.map((doc) => MessageModel.store(doc)));
    // .limit(limit)
  }

  void sendMessage(
    String from,
    String groupId,
    String message,
  ) {
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
    sendFCMMessage("Announcement", from, message);
  }
}
