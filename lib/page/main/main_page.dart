import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/page/message/message.dart';
import 'package:vn_dental/page/setting/setting.dart';
import 'package:vn_dental/page/widgets/pending_action.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/my_flutter_app_icons.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';

import 'main.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainBloc _bloc;
  SettingBloc _settingBloc;

  // ignore: close_sinks
  AuthenticationBloc _authenticationBloc;

  // ignore: close_sinks
  MessageBloc _messageBloc;

  // ignore: close_sinks
  int _currentIndex = 0;
  GlobalKey<NavigatorState> _currentTabKey;
  final GlobalKey<NavigatorState> listServiceNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> notificationNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> myOrderNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> listNewsNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> settingNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> createAppointmentNavKey =
      GlobalKey<NavigatorState>();

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _bloc = MainBloc(context);
    _settingBloc = SettingBloc();
    _messageBloc = MessageBloc();
    _currentTabKey = listServiceNavKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return WillPopScope(
      onWillPop: () {
        switch (_bloc?.prePosition) {
          case Const.HOME:
            _currentTabKey = listServiceNavKey;
            break;
          case Const.MY_ORDER:
            _currentTabKey = myOrderNavKey;
            break;
          case Const.APPOINTMENT:
            _currentTabKey = createAppointmentNavKey;
            break;
          case Const.APPOINTMENT:
            break;
          case Const.CHAT:
            _currentTabKey = listNewsNavKey;
            break;
          case Const.SETTING:
            _currentTabKey = settingNavKey;
            break;
        }
        if (_currentIndex == _bloc?.prePosition) {
          _currentTabKey.currentState.maybePop();
        }
        return Future.value(false);
      },
      child: MultiBlocProvider(
          providers: [
            BlocProvider<MainBloc>(
              create: (_) => _bloc,
            ),
            BlocProvider<SettingBloc>(
              create: (_) => _settingBloc,
            ),
            BlocProvider<MessageBloc>(
              create: (_) => _messageBloc,
            ),
          ],
          child: BlocListener<MainBloc, MainState>(
            listener: (context, state) {
              if (state is MainPageState) {
                _currentIndex = state.position;
              }
              if (state is RefreshAfterLoginSuccess) {
                try {
                  _settingBloc.add(RefreshSetting());
                  //_homeBloc.add(RefreshHome());
                  _messageBloc.add(GetListDoctor(
                      isRefresh: true, userID: _authenticationBloc.userID));
                } catch (e) {
                  print(e.toString());
                }
              }
            },
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return SafeArea(
                    top: false,
                    bottom: false,
                    child: Scaffold(
                      body: Stack(children: <Widget>[
                        IndexedStack(
                          index: _currentIndex,
                          children: [
                            Container(),
                            Container(),
                            Container(),
                            MessagePage(),
                            SettingPage()
                          ],
                        ),
                        Visibility(
                          visible: state is MainLoading,
                          child: PendingAction(),
                        )
                      ]),
                      bottomNavigationBar: ConvexAppBar(
                        initialActiveIndex: 0,
                        onTap: (int index) {
                          _bloc.add(NavigateBottomNavigation(index));
                          if (index == Const.HOME) {
                            _currentTabKey = listServiceNavKey;
                          } else if (index == Const.MY_ORDER) {
                            _currentTabKey = myOrderNavKey;
                          } else if (index == Const.APPOINTMENT) {
                            _currentTabKey = createAppointmentNavKey;
                          } else if (index == Const.CHAT) {
                            _currentTabKey = listNewsNavKey;
                          } else if (index == Const.SETTING) {
                            _currentTabKey = settingNavKey;
                          }
                        },
                        backgroundColor: white,
                        style: TabStyle.flip,
                        curveSize: height(250),
                        curve: Curves.bounceIn,
                        items: [
                          TabItem(
                              icon: Icon(
                            MyFlutterApp.home_outline,
                            color: _currentIndex == Const.HOME ? blue : grey,
                          )),
                          TabItem(
                              icon: Icon(
                            MyFlutterApp.calendar_outlilne,
                            color:
                                _currentIndex == Const.MY_ORDER ? blue : grey,
                          )),
                          TabItem(
                              icon: Icon(
                            MyFlutterApp.plus_outline,
                            //size: height(200),
                            color: _currentIndex == Const.APPOINTMENT
                                ? blue
                                : grey,
                          )),
                          TabItem(
                              icon: Icon(
                            MyFlutterApp.chat_alt,
                            color: _currentIndex == Const.CHAT ? blue : grey,
                          )),
                          TabItem(
                              icon: Icon(
                            MyFlutterApp.cog_outline,
                            color: _currentIndex == Const.SETTING ? blue : grey,
                          )),
                        ],
                      ),
                    ));
              },
            ),
          )),
    );
  }
}
