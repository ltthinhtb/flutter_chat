import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vn_dental/page/main/main.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/images.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    new Timer(new Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.asset(icLogo),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: 'Developed by ',
                        style: new TextStyle(color: black, fontSize: size(50)),
                      ),
                      new TextSpan(
                        text: Const.DENTAL,
                        style: new TextStyle(color: blue, fontSize: size(50)),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            //  Utils.launchURL(Utils.getTypeUrlLauncher(Const.URL_WEBSITE_DEV, Const.TYPE_WEB));
                          },
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
