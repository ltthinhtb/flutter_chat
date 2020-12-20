import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double height(double number) => ScreenUtil().setHeight(number);

double width(double number) => ScreenUtil().setWidth(number);

double size(double number) => ScreenUtil().setSp(number);

initScreenUtil(BuildContext context) => ScreenUtil.init(context,designSize: Size(1242,2688),
     allowFontScaling: false);
