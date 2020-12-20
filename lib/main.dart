import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/page/splash/splash_page.dart';
import 'package:vn_dental/page/widgets/pending_action.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/utils/const.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Widget _currentWidget;
  AuthenticationBloc _authenticationBloc;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    initializeDateFormatting();
    // TODO: implement initState
    _authenticationBloc = AuthenticationBloc(context);
    Timer(new Duration(milliseconds: 3000), () {
      _authenticationBloc.add(AppStarted());
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return RefreshConfiguration(
              headerBuilder: () => WaterDropMaterialHeader(),
              footerBuilder: () => ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                  ),
              headerTriggerDistance: 80.0,
              maxOverScrollExtent :100,
              maxUnderScrollExtent:0,
              enableScrollWhenRefreshCompleted: true,
              enableLoadingWhenFailed : true,
              hideFooterWhenNotFull: false,
              enableBallisticLoad: true,
              child: OverlaySupport(
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      locale: Locale(Const.EN),
                      localizationsDelegates: [
                        S.delegate,
                        RefreshLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      title: 'DENTAL APP',
                      theme: ThemeData(
                          primaryColor: primaryColor,
                          iconTheme: IconThemeData(color: white)),
                      home: Stack(
                        children: [
                          SplashPage(),
                          Visibility(
                            visible: state is AuthenticationLoading,
                            child: PendingAction(),
                          ),
                        ],
                      ))));
        },
      ),
    );
  }
}
