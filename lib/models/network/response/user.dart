import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String id;
  String avatarUrl;
  String token;

  User({this.name, this.id, this.avatarUrl,this.token});
  factory User.fromDoc(QueryDocumentSnapshot json){
    return User(
      name: json['name'],
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      token: json['token']
    );
  }
}
