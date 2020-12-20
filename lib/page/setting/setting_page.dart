import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/page/login/login_page.dart';
import 'package:vn_dental/page/main/main.dart';
import 'package:vn_dental/page/setting/setting.dart';
import 'package:vn_dental/page/widgets/appbar.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/my_flutter_app_icons.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingBloc _bloc;
  MainBloc _mainBloc;

  // ignore: close_sinks
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    // TODO: implement initState
    _mainBloc = BlocProvider.of<MainBloc>(this.context);
    _bloc = BlocProvider.of<SettingBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          _authenticationBloc.add(AppStarted());
          _mainBloc.add(ChangeAuthorizationEvent());
        }
      },
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: S.of(context).setting, isCenter: false),
            body: Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  rowMenu(!isLoggedIn(), S.of(context).login, MdiIcons.login,
                      () {
                    Utils.navigatePage(_mainBloc.context, LogInPage())
                        .then((value) {
                      if (value == Const.REFRESH) {
                        _authenticationBloc.add(AppStarted());
                        _mainBloc.add(ChangeAuthorizationEvent());
                        // _bloc.add(RefreshSetting());
                      }
                    });
                  }),
                  rowMenu(true, S.of(context).contact,
                      MyFlutterApp.phone
                      , () {}),
                  rowMenu(isLoggedIn(), S.of(context).log_out, MyFlutterApp.exit,
                      () {
                    _showConfirm(context);
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget rowMenu(
    bool isShowLoggedIn,
    String title,
    IconData icon,
    VoidCallback callback,
  ) {
    return Visibility(
      visible: isShowLoggedIn,
      child: InkWell(
        onTap: () => callback(),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width(50), vertical: 5),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: primaryColor, width: 0.3),
                      borderRadius: BorderRadius.circular(7)),
                  padding: EdgeInsets.all(7),
                  child: Icon(
                    icon,
                    size: height(70),
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: size(50)),
                textAlign: TextAlign.left,
              ),
              flex: 4,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width(50)),
              child: Icon(
                MyFlutterApp.chevron_right,
                color: grey,
                size: height(70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isLoggedIn() {
    return _authenticationBloc.isLoggedIn;
  }

  Future _showConfirm(BuildContext context) async {
    Utils.showDialogTextTwoButton(
        context: context,
        title: S.of(context).notice,
        contentText: S.of(context).confirm_logout,
        submitText: S.of(context).yes,
        submitCallback: () {
          _bloc.add(LogOutEvent());
        });
  }
}
