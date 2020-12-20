import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/models/network/response/facebook_login_response.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/models/service/network_factory.dart';
import 'dart:convert' as JSON;

import 'package:vn_dental/utils/const.dart';

class AuthService {
  BuildContext context;
  SharedPreferences _pref;

  AuthService(this.context);

  NetworkFactory _networkFactory;

  void init() {
    _networkFactory = NetworkFactory(context);
  }

  Future<User> signInWithGoogle() async {
    _pref = await SharedPreferences.getInstance();
    String token = _pref?.getString(Const.DEVICE_TOKEN);
    final GoogleSignInAccount googleSignIn = await GoogleSignIn().signIn();
    return User(
      name: googleSignIn.displayName,
      avatarUrl: googleSignIn.photoUrl ?? "",
      id: googleSignIn.id,
      token: token,
    );
  }

  Future<User> loginFaceBook() async {
    init();
    String token = _pref?.getString(Const.DEVICE_TOKEN);
    FacebookLogin facebookSignIn = new FacebookLogin();
    FacebookAccessToken accessToken;
    FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    FacebookLoginResponse response;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        accessToken = result.accessToken;
        final profile = JSON.jsonDecode(
            await _networkFactory.getFacebookResponse(accessToken.token));
        response = FacebookLoginResponse.fromJson(profile);
        _showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
    return User(
        avatarUrl: response.picture.data.url,
        name: response.name,
        id: response.id,
        token: token);
  }

  void _showMessage(String message) {
    print(message);
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await FacebookLogin().logOut();
  }
}
