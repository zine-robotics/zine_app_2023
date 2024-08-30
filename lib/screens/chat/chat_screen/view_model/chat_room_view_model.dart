import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/temp_message.dart';
import 'package:zineapp2023/models/temp_rooms.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/utilities/date_time.dart';

import '../../../../models/rooms.dart';
import '../repo/chat_repo.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final UserProv userProv;

  ChatRoomViewModel({required this.userProv}) {
    initializeWebSocket();  //constructor to initialize the webSocket for single time only!!
  }


  //===================================================NEWER CODE====================================================//
  final chatP = ChatRepo();
  Map<String, dynamic> _subscriptions = {};

  dynamic allData;
  dynamic replyTo;
  FocusNode replyfocus = FocusNode();
  FocusNode userReplyfocus = FocusNode();
  String _roomId = "352";
  final name = "Announcement";
  Map<String, dynamic> chatSubscription = {};
  final picker = ImagePicker();
  late TempMessageModel selectedReplyMessage;

  get roomId => _roomId;
  Map<String, Timestamp> lastChats = {};
  final CollectionReference _rooms =
      FirebaseFirestore.instance.collection('rooms');



  //-------------------message fetching using http--------------------//
  List<TempMessageModel> _messages = [];
  List<TempMessageModel> _tempMessages = [];
  bool _isLoading = false;
  final StreamController<List<TempMessageModel>> _messageStreamController=StreamController<List<TempMessageModel>>.broadcast();
  List<TempMessageModel> get messages => _messages;
  Set<String> activeRoomSubscriptions = {};

  bool get isLoading => _isLoading;
  Stream<List<TempMessageModel>> get messageStream =>_messageStreamController.stream;
  Future<void> fetchMessages(String TemproomId) async {
    _isLoading = true;
    // notifyListeners();

    try {
      _messages = await chatP.getChatMessages( TemproomId );
      // _error =null;
      _messageStreamController.add(_messages);
    } catch (e) {
      print(e);
      _messageStreamController.addError('Failed to load data');
      // _error ='Failed to load data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //-----------------------------------------stomp_client-----------------------------------------//

  late StompClient _client;

  bool isConnected = false;

  // late final messageData;

  final String webSocketUrl =
      'http://ec2-18-116-38-241.us-east-2.compute.amazonaws.com/ws';

  void initializeWebSocket() {
    print("\n----------initializing web socket------------\n ");
    _client = StompClient(
      config: StompConfig(
        useSockJS: true,
        url: webSocketUrl,
        onConnect: onConnectCallback,
        onWebSocketError: (dynamic error) => print('WebSocket error: $error'),
        // onDebugMessage: (dynamic message) => print('Debug: $message'),
      ),
    );
    print("Activating WebSocket client");
    _client.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    isConnected = true;
    print("inside the callback");
  }

  void subscribeToRoom(String roomId)
  {
    print("inside the subscribeToRoom & roomId:$roomId");
    if (!_client.connected ) {
      print("client is not connected");
      return;
    }
    // if (_subscriptions.containsKey(_roomId)) {
    //   _subscriptions[_roomId]?.unsubscribe();
    // }
    activeRoomSubscriptions.add(roomId);
    final subscription=_client.subscribe(
      destination: '/room/$roomId', //  widget.chatId
      headers: {},
      callback: (StompFrame frame) {
        // print("sucessfully connected:${frame.body}");
        // messageData = json.decode(frame.body!);
        // print("Successfully connected: ${json.decode(frame.body!)}");
        // print("inside the callback");

        try{
          final Map<String, dynamic> messageData = json.decode(frame.body!);
          TempMessageModel messageData1 =
          TempMessageModel.fromJson(messageData);
          // print("\nmessage added is:${messageData1}");
          _messages.add(messageData1);
          // List<TempMessageModel> tempMessageList = [messageData1];
          _messageStreamController.add(List.from(_messages));

          // _messages = List.from(_tempMessages); // Ensure _messages is updated
          // _messageStreamController.add(_messages);


        }
        catch(e)
        {
          print("\n error parsing messaging :${e} \n");
        }
        finally
        {
        notifyListeners();
        }
        // messages = jsonDecode(frame.body!).reversed.toList();
        // Notify listeners or update UI
      },
    );

    _subscriptions[roomId] = subscription;
    _roomId = roomId;
  }

  //---------------------------------------------MODIFY: ADD unsubscribe->to release the resource and keep track of active subsciber----------------//
  void unsubscribeFromRoom(String roomId) {
    print("attempting to unsubscribe roomId:$roomId");
    final subscription = _subscriptions[roomId];
    if (subscription != null) {
      try {

        // subscription.unsubscribe(unsubscribeHeaders: {});
        subscription();
        print("Unsubscribed from room: $roomId");
      } catch (e) {
        print("Error unsubscribing from room $roomId: $e");
      } finally {
        _subscriptions.remove(roomId);
      }
    } else {
      print("No active subscription found for room: $roomId");
    }
  }

  void setRoomId(String roomId) {
    print("insdie the setRoomID:$roomId");
    if(_roomId!=roomId)
      {
        unsubscribeFromRoom(_roomId);
        _roomId=roomId;
        subscribeToRoom(roomId);
      }
  }
  Map<String, int> roomNameToId = {
    "Backend": 302,
    "real-time-chat": 352,
    "task instance":902,
    "task instance": 652,
  };


  void sendMessage(String user_message, String roomName) async {
    // int? roomId=roomNameToId[roomName];
    if (!_client.connected) {
      print("Not connected to the WebSocket server.");
      return;
    }

    final messageData = {
      "type": "text",
      "content": user_message.toString(),
      "timestamp": DateTime.now().millisecondsSinceEpoch, // or DateTime.now().toIso8601String()
      "sentFrom": 403,
      "roomId": int.parse(_roomId),
      // "replyTo": null
    };
    // print("message_body:${messageData}");
    // final newMessage = TempMessageModel.fromJson(messageData);
    //
    // // Add the new message to the list
    // _messages.add(newMessage);
    //
    // // Update the stream with the new list of messages
    // _messageStreamController.add(List.from(_messages));

    final jsonBody = json.encode(messageData);

    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      print("\n-------message Sent--------\n");

    } catch (e) {
      print('Not connected to the WebSocket server.$e');
    }

    // Optionally, handle Firebase notifications if needed
    // sendFCMMessage(roomName, from, message);
  }


  //-------------------it will fetch all room data---------------------------------------------//
  //---------------MODIFY: get user details and pass email -------------//
  List<TempRooms>? _user_rooms;
  List<TempRooms>? _userProjects;
  bool _isRoomLoading=false;

  List<TempRooms>? get user_rooms => _user_rooms;
  List<TempRooms>? get userProjects => _userProjects;
  bool get isRoomLoading =>_isRoomLoading;
  Future<void> loadRooms() async {
    String email = 'herschellethomas10@gmail.com';

    _isRoomLoading=true;

    notifyListeners();
    try {
      List<TempRooms>?allRooms=await chatP.fetchRooms(email);
      if(allRooms !=null)
        {
          _user_rooms=allRooms.where((room)=>room.type=="group").toList();
          _userProjects=allRooms.where((room)=>room.type=="project").toList();
        }

      // _error =null;
    } catch (e) {
      print(e);
      // _error ='Failed to load data';
    } finally {
      _isRoomLoading=false;
      notifyListeners();
    }
  }


  dynamic getUserMessageById(List<TempMessageModel> chats, String replyTo) {
    print("inside the user message id:\n chats:${chats} \t replyTo:${replyTo}");
    Iterable<TempMessageModel> msg =
    chats.where((element) => element.id.toString() == replyTo);
    print("message is :${msg}");
    if (msg.isNotEmpty) {
      return msg.first;
    }
    return null;
  }

  void userReplyText(TempMessageModel message) {
    print("object");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    print(replyTo);

    replyfocus.requestFocus();

    notifyListeners();
  }
  void userCancelReply() {
    replyTo = null;
    print("repy to cancel");
    print(replyTo);
    notifyListeners();
  }
  dynamic userGetMessageById(List<TempMessageModel> chats, String replyTo) {
    print("inside the uerGetmessagebyId: chats:${chats} replyTo:${replyTo}");

    Iterable<TempMessageModel> msg =
    chats.where((element) => element.id.toString() == replyTo);
    if (msg.isNotEmpty) {
      return msg.first;
    }
    return null;
  }
  // void updateUserMessage(List<Message> messages, int messageId) {
  //   // Find the message with the given ID
  //   Message? message = messages.firstWhere((msg) => msg.id == messageId, orElse: () => null);
  //
  //   if (message != null) {
  //     // Update the replyTo field to null
  //     message.replyTo = null;
  //     print('Message updated successfully.');
  //   } else {
  //     print('Message with ID $messageId not found.');
  //   }
  // }
  //=====================================================older code===================================================================//



  var _data;
  var _docData;

  get data => _data;

  String _text = "";

  get text => _text;

  void setText(String value) {
    _text = value;
  }

  void getChats() async {
    allData = await chatP.getChatStream(_roomId);
  }

  void replyText(dynamic message) {
    print("object");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    print(replyTo);

    replyfocus.requestFocus();

    notifyListeners();
  }

  void cancelReply() {
    replyTo = null;
    print("repy to cancel");
    print(replyTo);
    notifyListeners();
  }

  dynamic getMessageById(List<MessageModel> chats, String replyTo) {
    Iterable<MessageModel> msg =
        chats.where((element) => element.id == replyTo);
    if (msg.isNotEmpty) {
      return msg.first;
    }
    return null;
  }

  List<dynamic> listOfUsers = [];

  void listenChanges(String name) {
    var id = null;
    // print(chatSubscription[name]);
    if (chatSubscription[name] == null) {
      _rooms
          .where("name", isEqualTo: name)
          .limit(1)
          .get()
          .then((value) => id = value.docs[0].id)
          .catchError((e) => {print(e)})
          .whenComplete(
            () => {
              if (id != null)
                {
                  chatSubscription[name] =
                      _rooms.doc(id).collection("messages").snapshots().listen(
                    (QuerySnapshot snapshot) {
                      for (var change in snapshot.docChanges) {
                        if (change.type == DocumentChangeType.added) {
                          // print("added");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.modified) {
                          // print("modified");
                          notifyListeners();
                        } else if (change.type == DocumentChangeType.removed) {
                          notifyListeners();
                        }
                      }
                    },
                  )
                }
            },
          );
    }
  }

  Stream<QuerySnapshot<Object?>> getData(roomName) async* {
    // print(roomName);
    allData = await chatP.getChatStream(roomName);
    yield* allData;
  }

  void send({from, roomId}) {
    // getChats();
    print("sending");
    print(replyTo);
    _text.isEmpty
        ? null
        : chatP.sendMessage(
            from, roomId, _text, replyTo, userProv!.getUserInfo.uid.toString());
    replyTo = null;
    setText("");

    notifyListeners();
  }

  void updateMessage(DocumentReference docRef) async {
    await docRef.update({'replyTo': null});
  }

  void replyListner() {
    if (!replyfocus.hasFocus) replyTo = null;
  }

  String _lastChatTime = "";

  get lastChatTime => _lastChatTime;

  void setTimeChat(String value) {
    _lastChatTime = value;
  }

  bool rederDate(var index) {
    return false;
  }

  dynamic getLastMessages(String roomName) async {
    print("function Called");
    dynamic timeStamp = await chatP.getLastChat(roomName);
    dynamic prev = lastChats;
    print(lastChats);
    print(roomName);
    if (timeStamp != null) {
      lastChats[roomName] = timeStamp;
    }

    if (!mapEquals(lastChats, prev)) notifyListeners();
  }

  bool unread(String name, UserModel user) {
    if (lastChats[name] != null) {
      if (user.lastSeen != null && user.lastSeen[name] != null) {
        return lastChats[name]!.compareTo(user.lastSeen[name]) > 0;
      }
    }
    return false;
  }

  // String lastChatRoom(var name) {
  //   if (lastChats[name] != null) {
  //     DateTime t = (lastChats[name] as Timestamp).toDate();
  //     DateTime now = DateTime.now();
  //     var lastChat;
  //     if ((now.day == t.day && t.month == now.month && t.year == now.year))
  //       lastChat = getTime(lastChats[name] as Timestamp);
  //     else
  //       lastChat =
  //           t.day.toString() + " " + getDate(lastChats[name] as Timestamp);
  //     return lastChat;
  //   }
  //   return "";
  // }

  void roomLeft(var room, var user, UserProv userProv) {
    chatP.updateLastSeen(user, room);
    userProv.updateLast(room);
    notifyListeners();
    print('left $room');
  }

  void addRouteListener(
      BuildContext context, var room, var user, UserProv userProv) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      // roomLeft(room, user, userProv);
      return Future.value(true);
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    dynamic imageFile;

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      await chatP.uploadImageToFirebase(imageFile);
    }
  }

  void disconnect() {
    for (var roomId in _subscriptions.keys) {
      unsubscribeFromRoom(roomId);
    }
    _client.deactivate();
    isConnected = false;
  }

  @override
  void dispose() {
    disconnect(); // Ensure clean-up on disposal
    _messageStreamController.close();
    super.dispose();
  }

}
