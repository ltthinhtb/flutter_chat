import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/log.dart';
import 'package:vn_dental/utils/utils.dart';

class DropdownColumnWidget extends StatefulWidget {
  final List<String> listData;
  final String currentValue;
  final ValueChanged<String> selectedValue;
  final String label;
  final Color color;
  final String hintText;

  const DropdownColumnWidget(
      {Key key,
      @required this.listData,
      this.currentValue,
      this.selectedValue,
      this.label,
      this.color,
      this.hintText})
      : super(key: key);

  @override
  _DropdownColumnWidgetState createState() => _DropdownColumnWidgetState();
}

class _DropdownColumnWidgetState extends State<DropdownColumnWidget> {
  int _selectedPos;
  List<String> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() {
    String firstElement = widget.hintText ?? "Chọn";
    if (!Utils.isEmpty(widget.listData)) {
      try {
        if (list?.last != widget?.listData?.last) _selectedPos = null;
      } catch (e) {
        logger.e(e.toString());
      }
      list = widget.listData;
      if (list.contains(firstElement)) {
        if (_selectedPos == null)
          _selectedPos = list?.indexOf(widget.currentValue);
        return;
      }
      list.insert(0, firstElement);

      if (_selectedPos == null)
        _selectedPos = list?.indexOf(widget.currentValue) ?? 0;
      if (_selectedPos < 0) {
        _selectedPos = 0;
      }
      if (!Utils.isEmpty(list) && widget.selectedValue != null) {
        String selectedValue = _selectedPos == 0 ? null : list[_selectedPos];
        widget.selectedValue(selectedValue);
      }
    } else {
      list = List()..add(firstElement);
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    int sizeList = list?.length ?? 0;
    return Container(
      height: height(220),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: grey),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: !Utils.isEmpty(widget.label),
            child: Text(
              widget.label ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: widget.color ?? grey,
                  fontSize: size(45),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
              visible: !Utils.isEmpty(widget.label),
              child: SizedBox(
                height: 5,
              )),
          Expanded(
            child: sizeList == 0
                ? Text(
                    "No data",
                    style: TextStyle(
                        color: widget.color ?? grey,
                        fontSize: size(32),
                        fontWeight: FontWeight.bold),
                  )
                : (sizeList == 1
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            list[0] ?? "",
                            style: TextStyle(
                              fontSize: size(45),
                              color: grey,
                              fontFamily: Const.FONT,
                            ),
                            maxLines: 2,
                          ),
                          Icon(
                            MdiIcons.menuDown,
                            color: grey,
                          )
                        ],
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            isDense: true,
                            style: TextStyle(
                              color: widget.color ?? black,
                              fontSize: size(45),
                            ),
                            hint: Text(
                              widget.hintText ?? "",
                              style: TextStyle(
                                  fontSize: size(45),
                                  color: blackBlur,
                                  fontFamily: Const.FONT),
                            ),
                            value: _selectedPos != null && _selectedPos >= 0
                                ? list[_selectedPos]
                                : list[0],
                            items: list
                                .map((item) => DropdownMenuItem<String>(
                                      child: Text(
                                        item ?? "",
                                        style: TextStyle(
                                            fontSize: size(45),
                                            color: widget.color ?? black,
                                            fontFamily: Const.FONT),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      value: item,
                                    ))
                                ?.toList(),
                            onChanged: widget.selectedValue == null
                                ? null
                                : (value) {
                                    print(value);
                                    setState(() {
                                      _selectedPos = list.indexOf(value);
                                    });
                                    String selectedValue = _selectedPos == 0
                                        ? null
                                        : list[_selectedPos];
                                    widget.selectedValue(selectedValue);
                                  }),
                      )),
          )
        ],
      ),
    );
  }
}
