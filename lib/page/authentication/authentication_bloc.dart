import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final BuildContext context;

  AuthenticationBloc(this.context) : super(Uninitialized());
  SharedPreferences _pref;
  FirebaseMessaging _firebaseMessaging;

  String userID;


  bool get isLoggedIn => !Utils.isEmpty(userID);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
    // TODO: implement mapEventToState
    if (event is AppStarted) {
      yield AuthenticationLoading();
      userID = _pref?.getString(Const.TOKEN) ?? "";
      _firebaseMessaging = FirebaseMessaging();
      _firebaseMessaging.getToken().then((token) {
        _pref?.setString(Const.DEVICE_TOKEN,token);
      });
      yield Authenticated();
    }
  }
}
