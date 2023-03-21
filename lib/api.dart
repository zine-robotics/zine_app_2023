import 'package:http/http.dart' as http;
import 'dart:convert';

// Define your FCM server key
const String serverKey =
    'AAAAbcVwtbU:APA91bET7ksps569G0nG29zoQXlRSf0jcRCsmGMVaimUz9qWl9Gf51Z1qirKwIfPr-Zjr2tiee8ftel-GoMoHer1_uUyMPSdKLlDzoES08CCmr8zmMKpK5lC6CjY0AeGHKpAuHD_bD6R';

Future<void> sendFCMMessage(String topic, String title, String body) async {
  // Define the message body
  print('/topics/$topic');
  final Map<String, dynamic> message = <String, dynamic>{
    'notification': <String, dynamic>{
      'title': title,
      'body': body,
    },
    'to': '/topics/$topic',
  };

  final String messageJson = json.encode(message);

  final http.Response response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$serverKey',
    },
    body: messageJson,
  );

  // Handle the response
  if (response.statusCode == 200) {
    print('FCM message sent to topic $topic!');
  } else {
    print('Error sending FCM message to topic $topic: ${response.body}');
  }
}
