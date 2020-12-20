import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:vn_dental/models/network/response/message.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/log.dart';

class FireBaseStore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    var userRef = firebaseFirestore.collection(Const.USERS);
    userRef.doc(user.id).get().then((value) async {
      if (!value.exists || value == null)
        await userRef.doc(user.id).set({
          "name": user.name,
          "id": user.id,
          "avatarUrl": user.avatarUrl,
          "token": user.token
        });
      if (value.data()['token'] != user.token) {
        await userRef.doc(user.id).update({"token": user.token});
      }
    });
  }

  Future<void> sendMessage(String chatID, Message message) async {
    var msgReference = firebaseFirestore.collection(Const.MESSAGES);
    await msgReference.doc(chatID).collection(chatID).add({
      Const.CONTENT: message.content,
      Const.TYPE: message.type,
      Const.USER_OWNER: message.userOwner,
      Const.DateTIME: message.dateTime,
      Const.IMAGE_OWNER: message.imageOwner,
      Const.USER: message.userName,
      Const.LIST_IMAGE_TYPE: message.listImage
    });
  }

  Future<void> deleteMessage(String chatID, String id) async {
    var msgReference = firebaseFirestore.collection(Const.MESSAGES);
    await msgReference.doc(chatID).collection(chatID).doc(id).delete();
  }

  Future<String> uploadFile(File file, bool isCompress) async {
    try {
      Uint8List result = await FlutterImageCompress.compressWithList(
        file.readAsBytesSync(),
        minHeight: 500,
        minWidth: 500,
        quality: 96,
      );
      await firebase_storage.FirebaseStorage.instance
          .ref('SendImageMessage/${file.path}}}')
          .putData(isCompress ? result : file.readAsBytesSync());
    } catch (e) {
      logger.d(e.toString());
    }
    String downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref('SendImageMessage/${file.path}}}')
        .getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadFileAsset(Asset file, bool isCompress) async {
    try {
      ByteData byteData = await file.getThumbByteData(1000, 1000);
      Uint8List uint8list = byteData.buffer.asUint8List();
      Uint8List result = await FlutterImageCompress.compressWithList(
        uint8list,
        minHeight: 500,
        minWidth: 500,
        quality: 96,
      );
      await firebase_storage.FirebaseStorage.instance
          .ref('SendImageMessage/${file.identifier}}}')
          .putData(isCompress ? result : uint8list);
    } catch (e) {
      logger.d(e.toString());
    }
    String downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref('SendImageMessage/${file.identifier}}}')
        .getDownloadURL();
    return downloadUrl;
  }
}
