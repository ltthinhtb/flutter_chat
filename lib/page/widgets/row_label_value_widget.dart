import 'package:flutter/material.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/utils.dart';


class RowLabelValueWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color colorValue;
  final VoidCallback callback;

  const RowLabelValueWidget(
      {Key key, this.label, this.value, this.colorValue, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !Utils.isEmpty(value),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                label ?? "",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: size(33),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: callback,
                    child: Text(
                      value ?? "",
                      style: TextStyle(
                        fontSize: size(40),
                        color: colorValue ?? Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
