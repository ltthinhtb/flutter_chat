import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vn_dental/utils/const.dart';

class Message {
  List<String> tokenDevice;
  String type;
  String id;
  String userOwner;
  String dateTime;
  String content;
  List<dynamic> listImage = List();
  String imageOwner;
  String userName;

  Message(
      {this.type,
      this.userOwner,
      this.dateTime,
      this.content,
      this.imageOwner,
      this.id,
      this.tokenDevice,
      this.userName,
      this.listImage});

  factory Message.fromDoc(DocumentSnapshot json) {
    return Message(
      dateTime: json[Const.DateTIME],
      userOwner: json[Const.USER_OWNER],
      type: json[Const.TYPE],
      content: json[Const.CONTENT],
      imageOwner: json[Const.IMAGE_OWNER],
    );
  }

  factory Message.fromQuery(QueryDocumentSnapshot json) {

    return Message(
      dateTime: json[Const.DateTIME],
      userOwner: json[Const.USER_OWNER],
      type: json[Const.TYPE],
      content: json[Const.CONTENT],
      imageOwner: json[Const.IMAGE_OWNER],
      listImage: json.data()[Const.LIST_IMAGE_TYPE] ?? []
    );
  }
}
