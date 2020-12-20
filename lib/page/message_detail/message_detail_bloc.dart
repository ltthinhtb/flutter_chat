import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/models/service/cloud_firestore.dart';
import 'package:vn_dental/models/service/notification.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';
import 'message_detail.dart';

class MessageDetailBloc extends Bloc<MessageDetailEvent, MessageDetailState> {
  MessageDetailBloc() : super(InitMessageDetailState());
  SharedPreferences _pref;

  File image;
  int limit = Const.limit;
  int limitIncrement = Const.limitIncrement;
  FireBaseStore fireBaseStore = FireBaseStore();
  DateFormat format = DateFormat(Const.SEND_TIME);
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Const.MESSAGES);
  String userName;
  String avatarUser;
  bool activeStatus = true;
  bool hasPermission;
  bool isOnTyping = false;
  bool isCompress = true;

  String get _userName => _pref.getString(Const.FULL_NAME);

  String get _avatarUser => _pref.getString(Const.AVATAR);

  Stream<QuerySnapshot> stream;

  @override
  Stream<MessageDetailState> mapEventToState(MessageDetailEvent event) async* {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
    if (event is SentMessage) {
      yield MessageDetailLoading();
      if (Utils.isEmpty(event.message.content))
        return;
      else {
        await fireBaseStore.sendMessage(event.chatId, event.message);
        FCMNotification(message: event.message).sendAndRetrieveMessage();
        isOnTyping = false;
        yield SendMessageSuccess();
      }
    }
    if (event is ImagePick) {
      yield MessageDetailLoading();
      if (event.isCamera) {
        String url;
        try {
          final imagePicker =
              await ImagePicker().getImage(source: ImageSource.camera);
          image = File(imagePicker.path);
          url = await fireBaseStore.uploadFile(image, isCompress);
          event.message.content = url;
          event.message.imageOwner = avatarUser;
          await fireBaseStore.sendMessage(event.chatID, event.message);
          FCMNotification(message: event.message).sendAndRetrieveMessage();
          yield SendMessageSuccess();
        } catch (e) {
          print(e.toString());
          yield SendMessageFailure();
        }
      } else
        try {
          List<Asset> listImages = List<Asset>();
          listImages = await MultiImagePicker.pickImages(
            maxImages: 10,
            enableCamera: true,
            selectedAssets: listImages,
            cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
            materialOptions: MaterialOptions(
              actionBarColor: "#abcdef",
              actionBarTitle: "Thư viện",
              allViewTitle: "Tất cả hình ảnh",
              useDetailsView: true,
              selectCircleStrokeColor: "#000000",
            ),
          );
          List<String> urls = List();
          for (Asset asset in listImages) {
            String url = await fireBaseStore.uploadFileAsset(asset, isCompress);
            urls.add(url);
          }
          event.message.listImage = urls;
          event.message.imageOwner = avatarUser;
          await fireBaseStore.sendMessage(event.chatID, event.message);
          FCMNotification(message: event.message).sendAndRetrieveMessage();
          yield SendMessageSuccess();
        } on Exception catch (e) {
          print(e.toString());
        }
    }

    if (event is LoadMessage) {
      hasPermission = await FlutterAudioRecorder.hasPermissions;
      bool isLoadMore = event.isLoadMore;
      userName = _userName;
      avatarUser = _avatarUser;
      yield MessageDetailLoading();
      if (isLoadMore) {
        limit += limitIncrement;
      }
      yield LoadMessageDetailSuccess();
    }
    if (event is OnTypingEvent) {
      yield MessageDetailLoading();
      if (Utils.isEmpty(event.text))
        isOnTyping = false;
      else
        isOnTyping = true;
      yield InitMessageDetailState();
    }

    if (event is IsCompress) {
      yield MessageDetailLoading();
      isCompress = !isCompress;
      yield InitMessageDetailState();
    }

    if (event is DeleteMessage) {
      yield MessageDetailLoading();
      await fireBaseStore.deleteMessage(event.chatId, event.messageID);
      yield DeleteMessageSuccess();
    }
    if (event is AudioRecorder) {
      yield MessageDetailLoading();
      var recorder = FlutterAudioRecorder("file_path",
          audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
      await recorder.initialized;
      await recorder.start();
      //var recording = await recorder.current(channel: 0);
      yield SendMessageSuccess();
    }
  }
}
