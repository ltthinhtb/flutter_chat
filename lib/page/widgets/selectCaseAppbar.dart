import 'package:flutter/material.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';

Widget selectCaseAppbar(BuildContext context, int step) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white10,
    bottom: PreferredSize(
        child: Stack(
          children: [
            Divider(
              thickness: 3,
              color: grey_300,
            ),
            Divider(
              thickness: 3,
              color: blue,
              endIndent: MediaQuery.of(context).size.width / 5 * (5 - step),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(height(50))),
    iconTheme: IconThemeData(color: black),
    title: Text(
      S.of(context).stepOf + " $step" + " trên 5",
      style: TextStyle(
          fontSize: size(60), color: black, fontWeight: FontWeight.w500),
    ),
  );
}
