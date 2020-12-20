import 'package:flutter/material.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';

class ButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String title;
  final VoidCallback onPressed;
  final double radius;
  final bool modeFlatButton;
  final TextStyle style;
  final double heightB;

  ButtonWidget(
      {this.backgroundColor,
      this.style,
      this.textColor,
      @required this.title,
      @required this.onPressed,
      this.radius,
      this.modeFlatButton: false,
      this.heightB});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
//        color: backgroundColor,
        alignment: Alignment.center,
        height: heightB ?? height(180),
        padding: EdgeInsets.symmetric(horizontal: width(100)),
        decoration: BoxDecoration(
            color: backgroundColor ?? primaryColor,
//            gradient: LinearGradient(
//              colors: [Theme.of(context).primaryColor, Colors.lightBlue],
//            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          title,
          style: style ??
              TextStyle(color: textColor ?? Colors.white, fontSize: size(50)),
        ),
      ),
    );
  }
}
