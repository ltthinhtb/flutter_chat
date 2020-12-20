import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vn_dental/models/network/response/message.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:http/http.dart' as http;

class FCMNotification {
  final String serverToken = Const.FCM_KEY;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final Message message;

  FCMNotification({this.message});

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message.type == Const.MESSAGE_TYPE
                ? message.content
                : "${message.userName} đã gửi cho bạn hình ảnh",
            'title': message.userName
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'body': message.type == Const.MESSAGE_TYPE
                ? message.content
                : "${message.userName} đã gửi cho bạn hình ảnh",
            'title': message.userName
          },
          'to': message.tokenDevice[0],
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
      onResume: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
