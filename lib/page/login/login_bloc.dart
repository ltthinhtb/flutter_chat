import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/models/service/auth_service.dart';
import 'package:vn_dental/models/service/cloud_firestore.dart';
import 'package:vn_dental/page/login/login.dart';
import 'package:vn_dental/utils/utils.dart';
import 'package:vn_dental/utils/validator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  BuildContext context;
  String errorEmail;
  String errorPass;
  AuthService _authService;
  SharedPreferences _pref;
  User user;
  FireBaseStore fireBaseStore = FireBaseStore();

  LoginBloc(this.context) : super(LoginInitial()) {
    _authService = AuthService(this.context);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
    if (event is ValidateEmail) {
      yield LoginInitial();
      errorEmail = checkEmail(context, event.email);
      yield ValidateError();
    }

    if (event is ValidatePass) {
      yield LoginInitial();
      errorPass = checkPass(context, event.pass);
      yield ValidateError();
    }

    if (event is LoginGoogle) {
      yield LoginLoading();
      try {
        user = await _authService.signInWithGoogle();
        await fireBaseStore.addUser(user);
        Utils.saveUser(_pref, user);
        yield LoginSuccess();
      } catch (e) {
        yield LoginFailure(e.toString());
      }
    }
    if (event is LoginFacebook) {
      yield LoginLoading();
      try {
        user = await _authService.loginFaceBook();
        await fireBaseStore.addUser(user);
        Utils.saveUser(_pref, user);

        yield LoginSuccess();
      } catch (e) {
        yield LoginFailure(e.toString());
      }
    }

    // if (event is LoginApple) {
    //   yield LoginLoading();
    //   try {
    //     final credential = await SignInWithApple.getAppleIDCredential(
    //       scopes: [
    //         AppleIDAuthorizationScopes.email,
    //         AppleIDAuthorizationScopes.fullName,
    //       ],
    //       webAuthenticationOptions: WebAuthenticationOptions(
    //         // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
    //         clientId: 'com.aboutyou.dart_packages.sign_in_with_apple.example',
    //         redirectUri: Uri.parse(
    //           'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
    //         ),
    //       ),
    //     );
    //     print(credential);
    //     final signInWithAppleEndpoint = Uri(
    //       scheme: 'https',
    //       host: 'flutter-sign-in-with-apple-example.glitch.me',
    //       path: '/sign_in_with_apple',
    //       queryParameters: <String, String>{
    //         'code': credential.authorizationCode,
    //         'firstName': credential.givenName,
    //         'lastName': credential.familyName,
    //         'useBundleId':
    //             Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
    //         if (credential.state != null) 'state': credential.state,
    //       },
    //     );
    //     final session = await http.Client().post(
    //       signInWithAppleEndpoint,
    //     );
    //     print(session.body);
    //     yield LoginSuccess();
    //   } catch (e) {
    //     yield LoginFailure(e.toString());
    //   }
    // }
  }
}
