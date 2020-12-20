import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';


class TicketWidget extends StatefulWidget {
  final String busName;
  final String amount;
  final String seats;
  final String sourceLocation;
  final String destinationLocation;
  final String startTime;
  final String endTime;
  final String dayTime;

  const TicketWidget(
      {Key key,
      this.busName,
      this.amount,
      this.seats,
      this.sourceLocation,
      this.destinationLocation,
      this.startTime,
      this.endTime,
      this.dayTime})
      : super(key: key);

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 10, bottom: 5),
              child: Row(
                children: [
                  Image.asset(
                    'res/images/busIcon.png',
                    width: 50,
                    height: 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.busName,
                            style: TextStyle(
                                fontSize: size(50),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(widget.seats)
                        ],
                      ),
                    ),
                  ),
                  Text(
                    widget.amount,
                    style: TextStyle(
                        color: red,
                        fontSize: size(40),
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 20, bottom: 5),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sourceLocation,
                        style: TextStyle(
                            fontSize: size(50), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.endTime + ", ${widget.dayTime}")
                    ],
                  ),
                  Expanded(child: Icon(Icons.arrow_forward)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.destinationLocation,
                        style: TextStyle(
                            fontSize: size(50), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.startTime + ", ${widget.dayTime}")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
