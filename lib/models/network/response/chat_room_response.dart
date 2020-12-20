import 'package:vn_dental/models/network/response/message.dart';
import 'package:vn_dental/models/network/response/user.dart';

class ChatRoom {
  String id;
  List<User> users;
  List<Message> messages;

  ChatRoom({this.id, this.users, this.messages});
}
