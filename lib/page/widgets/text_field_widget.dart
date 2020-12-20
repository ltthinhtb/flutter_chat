import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {@required this.controller,
//      this.key,
      this.textInputAction: TextInputAction.next,
      this.isEnable = true,
      this.autoFocus = false,
      this.onChanged,
      this.isPassword: false,
      this.icon,
      this.errorText,
      this.labelText,
      this.hintText,
      this.inputFormatters,
      this.maxLines,
      this.keyboardType: TextInputType.text,
      this.focusNode,
      this.readOnly: false,
      this.onTap,
      this.onSubmitted});

//  final GlobalKey key;
  final TextEditingController controller;
  final bool isEnable;
  final bool autoFocus;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String> onChanged;
  final bool isPassword;
  final String errorText;
  final String labelText;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSubmitted;
  final dynamic icon;
  final bool readOnly;
  final Function onTap;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        key: widget.key,
        enabled: widget.isEnable,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: _obscureText,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: accent, width: 1)),
            hintText: widget.hintText,
            labelText: widget.labelText ?? null,
            errorText: widget.errorText,
            prefixIcon: widget.icon == null
                ? null
                : (widget.icon is String
                    ? Padding(
                        child: Image.asset(
                          widget.icon,
                          fit: BoxFit.fitHeight,
                          height: 5,
                        ),
                        padding: EdgeInsets.all(12),
                      )
                    : Icon(
                        widget.icon,
                        size: height(70),
                      )),
            suffixIcon: widget.readOnly == true
                ? null
                : (!widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          widget.controller.clear();
                          widget.onChanged("");
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: height(80),
                          semanticLabel: 'clear',
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? MdiIcons.eye : MdiIcons.eyeOff,
                          size: height(80),
                          semanticLabel:
                              _obscureText ? 'show password' : 'hide password',
                        ),
                      )),
            labelStyle: TextStyle(
                fontSize: size(45), color: widget.isEnable ? black : grey),
            hintStyle: TextStyle(
              fontSize: size(40),
              color: grey,
            ),
            errorStyle: TextStyle(
              fontSize: size(35),
              color: red,
            )),
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        maxLines: widget.isPassword == true ? 1 : widget.maxLines,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: size(45),
          color: widget.isEnable ? black : grey,
        ),
      ),
    );
  }
}
