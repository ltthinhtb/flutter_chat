import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: this.height),
        ),
      ),
    );
  }
}
