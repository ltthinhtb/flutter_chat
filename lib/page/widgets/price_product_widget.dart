import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/log.dart';

class PriceProductWidget extends StatefulWidget {
  final String initPrice;
  final bool isEnable;
  final ValueChanged<String> valueChanged;

  PriceProductWidget(
      {Key key, this.initPrice, this.valueChanged, this.isEnable = false})
      : super(key: key);

  @override
  _PriceProductWidgetState createState() => _PriceProductWidgetState();
}

class _PriceProductWidgetState extends State<PriceProductWidget> {
  String _price;
  TextEditingController _controller;
  bool _isEditing = false;
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    _price = widget.initPrice == null ? "" : widget.initPrice.toString();
    _controller.text = _price;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Visibility(
          visible: widget.initPrice == null && widget.isEnable,
          child: IconButton(
              icon: Icon(
                _isEditing ? MdiIcons.check : MdiIcons.pencilOutline,
                color: accent,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  updatePrice(context);
                });
              }),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: widget.initPrice == null && widget.isEnable,
              child: IconButton(
                  icon: Icon(
                    _isEditing ? MdiIcons.check : MdiIcons.pencilOutline,
                    color: accent,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      updatePrice(context);
                    });
                  }),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 100,
                height: 30,
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomCenter,
                child: TextField(
                  focusNode: _focusNode,
                  enabled: _isEditing,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (text) => updatePrice(context),
                  style: TextStyle(
                    color: red,
                    fontSize: size(40),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Giá",
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void updatePrice(BuildContext context) {
    _isEditing = !_isEditing;
    if (!_isEditing) {
      _focusNode.unfocus();
      if (widget.valueChanged != null) {
        try {
          String price = _controller.text.trim();
          widget.valueChanged(price);
        } catch (e) {
          logger.e(e.toString());
        }
      }
    } else
      FocusScope.of(context).requestFocus(_focusNode);
  }
}
