import 'package:flutter/material.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';

Widget appBar({String title, List<Widget> actions, bool isCenter}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: size(60), color: black),
    ),
    centerTitle: isCenter ?? true,
    actions: actions,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: black),
    elevation: 1,
    // actionsIconTheme: IconThemeData(size: height(75)),
  );
}
