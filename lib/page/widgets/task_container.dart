import 'package:flutter/material.dart';
import 'package:vn_dental/models/network/response/list_appointment_response.dart';
import 'package:vn_dental/themes/sizes.dart';

class TaskContainer extends StatelessWidget {
  final Appointment appointment;
  final Color boxColor;

  TaskContainer({
    this.boxColor,
    this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: height(400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

        ],
      ),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
