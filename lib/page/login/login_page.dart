import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/page/signup/sign_up_page.dart';
import 'package:vn_dental/page/widgets/appbar.dart';
import 'package:vn_dental/page/widgets/button_widget.dart';
import 'package:vn_dental/page/widgets/pending_action.dart';
import 'package:vn_dental/page/widgets/text_field_widget.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/images.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';
import 'login.dart';

class LogInPage extends StatefulWidget {
  final ValueChanged<dynamic> valueChanged;

  const LogInPage({Key key, this.valueChanged}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  LoginBloc _loginBloc;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

  @override
  void initState() {
    _loginBloc = LoginBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      backgroundColor: white,
      appBar: appBar(title: S.of(context).login),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Utils.showErrorSnackBar(context, S.of(context).login_error);
            }
            if (state is LoginSuccess) Navigator.pop(context, Const.REFRESH);
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SafeArea(
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    height: height(500),
                                    child: Image.asset(icLogo),
                                  ),
                                  TextFieldWidget(
                                    controller: _emailController,
                                    textInputAction: TextInputAction.next,
                                    errorText: _loginBloc.errorEmail,
                                    labelText: S.of(context).email,
                                    autoFocus: false,
                                    onChanged: (text) =>
                                        _loginBloc.add(ValidateEmail(text)),
                                    focusNode: _nameFocusNode,
                                    onSubmitted: (text) =>
                                        Utils.navigateNextFocusChange(context,
                                            _nameFocusNode, _passFocusNode),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldWidget(
                                    isPassword: true,
                                    focusNode: _passFocusNode,
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.go,
                                    labelText: S.of(context).password,
                                    autoFocus: false,
                                    errorText: _loginBloc.errorPass,
                                    onChanged: (text) =>
                                        _loginBloc.add(ValidatePass(text)),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: ButtonWidget(
                                          title: S
                                              .of(context)
                                              .sign_in
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: size(50),
                                              color: white,
                                              fontWeight: FontWeight.w500),
                                          onPressed: null)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () => Utils.navigatePage(
                                              context, SignUpPage()),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20.0),
                                            child: Text(
                                              S.of(context).not_account,
                                              style: TextStyle(
                                                  fontSize: size(45),
                                                  color: black,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          )),
                                      GestureDetector(
                                          onTap: () => Utils.navigatePage(
                                              context, Container()),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20.0),
                                            child: Text(
                                              S.of(context).forgot_password,
                                              style: TextStyle(
                                                  fontSize: size(45),
                                                  color: black,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Divider(
                                            height: 3.0,
                                            color: black,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            S.of(context).or_connect_with,
                                            style: TextStyle(
                                              fontSize: size(45),
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Divider(
                                            height: 3.0,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                onPressed: () {
                                  _loginBloc.add(LoginFacebook());
                                },
                                color: Color(0xFF3b5998),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.facebook,
                                      color: white,
                                    ),
                                    Text(
                                      S.of(context).facebook.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: size(45),
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                onPressed: () => _loginBloc.add(LoginGoogle()),
                                color: red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.googlePlus,
                                      color: white,
                                    ),
                                    Text(
                                      S.of(context).google.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: size(45),
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                onPressed: () => _loginBloc.add(LoginApple()),
                                color: black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.apple,
                                      color: white,
                                    ),
                                    Text(
                                      S.of(context).apple.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: size(45),
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state is LoginLoading,
                        child: PendingAction(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
