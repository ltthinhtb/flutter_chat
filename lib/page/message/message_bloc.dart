import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';

import 'message.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  SharedPreferences _prefs;
  CollectionReference users =
      FirebaseFirestore.instance.collection(Const.USERS);
  User selectUser;

  String userID;

  String get _userID => _prefs.getString(Const.TOKEN);

  MessageBloc() : super(InitMessageState());

  Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      userID = _userID;
    }
  }

  List<User> list = List();

  List<User> searchDoctor(String text) {
    return list
        .where((element) => Utils.convertVNtoText(element.name.toLowerCase())
            .contains(Utils.convertVNtoText(text)))
        .toList();
  }

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is SelectDoctor) {
      yield MessageLoading();
      selectUser = event.doctorData;
      yield InitMessageState();
    }
    if (event is GetListDoctor) {
      yield MessageLoading();
      yield InitMessageState();
    }
    if (event is RefreshChatLogin) {
      yield MessageLoading();
      yield MessageLoginSuccess();
    }
  }
}
