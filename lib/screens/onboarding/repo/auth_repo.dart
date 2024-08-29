import 'dart:convert';
import 'package:http/http.dart';
import 'package:requests/requests.dart';
import 'package:zineapp2023/models/rooms.dart';
import 'package:zineapp2023/models/tasks.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/backend_properties.dart';
import '/common/data_store.dart';
import '../../../models/user.dart';

class AuthRepo {
  // final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late DataStore store;

  AuthRepo({required this.store});

  Future<bool> sendResetEmail(String email) async {
    Response res = await Requests.post(
      BackendProperties.resetUri
          .replace(queryParameters: {'email': email.toString()}).toString(),
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    Response res = await http.post(BackendProperties.loginUri,
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    String userToken = "";
    print("Reponse Code ${res.statusCode}");
    // String toastText = 'An Undefined Error Occured';

    switch (res.statusCode) {
      case 403:
        Map<String, dynamic> resBody = jsonDecode(res.body);
        if (resBody['failureReason'] == 'USER_NOT_VERIFIED_EMAIL_RESENT' ||
            resBody['failureReason'] == 'USER_NOT_VERIFIED') {
          throw AuthException(code: 'unverified-emai');
        }

        throw AuthException(code: '403 Error');

      case 400:
        throw AuthException(code: 'user-not-exist');

      case 200:
        Map<String, dynamic> resBody = jsonDecode(res.body);
        if (!resBody.containsKey('jwt')) {
          throw AuthException(code: 'backend-not-responding');
        } else {
          userToken = (resBody['jwt'] as String);
        }
    }

    return getUserbyId(userToken);
  }

  Future<bool> isUserReg(String email) async {
    //FIXME : Implement This
    return true;
  }

  dynamic getRoomMap(dynamic listRoomIds) async {
    dynamic roomDetails = {"group": {}, "project": {}};
    for (var roomId in listRoomIds) {
      // print(item);
      //IM JUST WINGING IT OVER HERE WELL BURN THE BRIDGES WHEN WE GET TO EM
      Response res = await Requests.get(
          BackendProperties.roomDataUri.toString(),
          body: jsonEncode({'roomId': "$roomId"}),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode != 200) {
        throw AuthException(code: 'It should probably return 200. Test Throw');
      }

      Map<String, dynamic> temp = jsonDecode(res.body);
      // print(temp['type']);

      roomDetails[temp['type']][roomId] = temp['name'];
    }
    return roomDetails;
  }

  // Future<Tasks> getTemp(UserTask e) async {
  //   // We are just Seeing if the given UserTask has any links and if it doesnt
  //   DocumentSnapshot<Map<String, dynamic>> snapshot = await e.task!.get()
  //       as DocumentSnapshot<Map<String, dynamic>>; // get tasks

  //   if (!snapshot.data()!.containsKey('link')) {
  //     // if task  doees not has link
  //     snapshot.data()!['links'] = []; //
  //     await e.task!.update({'link': []}); //set link = 0
  //   }

  //   Tasks data = Tasks.store(snapshot);

  //   return data;
  // }

  Future<List<UserTask>?> getTasks(uid) async {
    //FIXME: Implement tits
  }

  Future<List<Rooms>?> getRoomIds(uid) async {
    Response res = await Requests.get(BackendProperties.roomDataUri.toString(),
        queryParameters: {"email": "shmokedev2@gmail.com"}); //TODO: FIX THIS
    return [];
  }

  Future<UserModel?> getUserbyId(String uid) async {
    Response res = await Requests.get(BackendProperties.userInfoUri.toString(),
        headers: {'Authorization': 'Bearer $uid'});

    if (res.statusCode != 200 || res.body.isEmpty) return null;
    print('User Body ${res.body}');
    Map<String, dynamic> user = jsonDecode(res.body);

    //USER DOES NOT HAVE TASKIDS, ENDPOINT FOR QUERYING USER'S TASK IDS

    var tasks = await getTasks(uid);
    var rooms = await getRoomIds(uid);

    var roomDetails = getRoomMap(rooms);

    // // List<Future<void>> futures = [];
    // // for (var e in tasks!) {
    // futures.add(getTemp(e).then((value) => e.template = value));
    // // }

    // await Future.wait(futures);

    // // print(tasks);

    // Above code just set User's links to empty, if the key wasnt created

    UserModel userMod = UserModel(
        uid: uid,
        email: user['email'],
        name: user['name'],
        dp: int.tryParse(user['dp'] ?? "1"),
        type: user['type'],
        registered:
            user['registered']! ?? false, //SDK CONSTRAINTS MIGHT F WITH THIS
        tasks: tasks,
        rooms: rooms,
        roomIDs: rooms,
        roomDetails: roomDetails, // FIXME:
        lastSeen: user['lastSeen'] ?? {});

    return userMod;
  }

  Future<UserModel?> createUserWithEmailAndPassword({
    String name = 'New Recruit',
    String email = 'a@gmail.com',
    String password = 'password',
  }) async {
    //Verification mail is sent automatically.
//TODO: ADD TRY CATCH

    Response res = await http.post(BackendProperties.registerUri,
        body: jsonEncode({"name": name, "email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    print("THSHFkjsdh ${res.statusCode}");
    print("djsfkjsdf ${res.url}");
    if (res.statusCode != 200) {
      throw AuthException(code: 'Auth Error');
    }

    return UserModel();
  }

  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
    store.delete(key: 'uid');
    store.setString('loggedIn', 'true');
  }
}

class AuthException implements Exception {
  String code;

  AuthException({required this.code});
}
