import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/models/network/response/billing_address.dart';
import 'package:vn_dental/models/network/response/list_appointment_response.dart';
import 'package:vn_dental/models/network/response/list_case_response.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/images.dart';

import 'const.dart';
import 'log.dart';

class Utils {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      logger.d('Internet not connect');
    }
    return false;
  }

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: primaryColor,
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showErrorSnackBar(BuildContext context, String text) {
    onWidgetDidBuild(() => showSnackBar(context, text));
  }

  static String getTypeUrlLauncher(String url, int type) {
    switch (type) {
      case Const.TYPE_WEB:
        return url;
      case Const.TYPE_EMAIL:
        return "mailto:$url";
      case Const.TYPE_PHONE:
        return "tel:$url";
      case Const.TYPE_SMS:
        return "sms:$url";
    }
    return url;
  }

  static Future launchURL(String url) async {
    url = url.replaceAll(" ", "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      logger.d('Đã có lỗi xảy ra');
    }
  }

  static bool isEmpty(Object text) {
    if (text is String) return text == null || text.isEmpty;
    if (text is List) return text == null || text.isEmpty;
    return text == null;
  }

  static bool isEmptyArray(List list) {
    return list == null || list.isEmpty;
  }

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  static Color parseStringToColor(String color) {
    if (Utils.isEmpty(color))
      return Colors.white;
    else
      return Color(int.parse('0xff' + color.substring(1)));
  }

  static String parseDateToString(DateTime dateTime, String format,
      {String locale}) {
    String date = "";
    if (dateTime != null)
      try {
        date = DateFormat(format, locale ?? "Vi_vi").format(dateTime);
      } on FormatException catch (e) {
        logger.e(e.toString());
      }
    return date;
  }

  static String fullTime(Appointment appointment) {
    return appointment.dateTime + " " + appointment.startTime;
  }

  static String getAddress(BillingAddress billingAddress) {
    if (billingAddress == null) return null;
    String address = billingAddress.address1;
    String state = billingAddress.ward;
    String city = billingAddress.city;
    String district = billingAddress.district;
    String result = "";
    if (!Utils.isEmpty(address)) {
      result += address;
    }
    if (!Utils.isEmpty(state)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += state;
    }
    if (!Utils.isEmpty(district)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += district;
    }
    if (!Utils.isEmpty(city)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += city;
    }
//    if (!Utils.isEmpty(country)) {
//      result += ", ";
//      result += country;
//    }
    return result;
  }

  static String parseStringDateToString(
      String dateSv, String fromFormat, String toFormat) {
    String date = dateSv ?? "";
    if (dateSv != null)
      try {
        date = DateFormat(toFormat, "en_US")
            .format(DateFormat(fromFormat).parse(dateSv));
      } on FormatException catch (e) {
        logger.d(e.toString());
      }
    return date;
  }

  static Future showDialogTextTwoButton(
      {@required BuildContext context,
      String title,
      @required String contentText,
      @required String submitText,
      @required VoidCallback submitCallback,
      bool dismissible: false}) {
    return showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: !Utils.isEmpty(title) ? Text(title ?? "") : null,
              content: Text(contentText ?? ""),
              actions: [
                FlatButton(
                  onPressed: () => popDialog(context),
                  child: Text(S.of(context).close),
                ),
                Visibility(
                  visible: !Utils.isEmpty(submitText),
                  child: FlatButton(
                    onPressed: () {
                      popDialog(context);
                      submitCallback();
                    },
                    child: Text(submitText ?? ''),
                  ),
                )
              ]);
        });
  }

  static Future showDialogTwoButton(
      {@required BuildContext context,
      String title,
      @required Widget contentWidget,
      @required String submitText,
      @required VoidCallback submitCallback,
      bool dismissible: false}) {
    return showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: title != null ? Text(title) : null,
              content: contentWidget,
              actions: [
                FlatButton(
                  onPressed: () => popDialog(context),
                  child: Text(S.of(context).close),
                ),
                Visibility(
                  visible: !Utils.isEmpty(submitText),
                  child: FlatButton(
                    onPressed: () {
                      popDialog(context);
                      submitCallback();
                    },
                    child: Text(submitText ?? ''),
                  ),
                )
              ]);
        });
  }

  static void showDialogTwoButtonAfterLayout(
      {@required BuildContext context,
      String title,
      @required Widget contentWidget,
      @required List<Widget> actions}) async {
    onWidgetDidBuild(() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: title != null ? Text(title) : null,
              content: contentWidget,
              actions: actions);
        }));
  }

  static Future pushAndRemoveUtilPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  static Future pushAndRemoveUtilKeepFirstPage(
      BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  static void popToFirst(BuildContext context) {
    return Navigator.of(context)
        .popUntil((Route<dynamic> route) => route.isFirst);
  }

  static void popByTime(BuildContext context, int count, {dynamic result}) {
    for (int i = 0; i < count - 1; i++) Navigator.of(context).pop();

    Navigator.of(context).pop(result);
  }

  static void popUtil(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => false);
  }

  static void popDialog(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static Future rootNavigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static navigateNextFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static String keyUserName(String userName) {
    return '${Const.USER_KEY_PREFIX}$userName';
  }

  static String passwordEncrypt(String password) {
    return '${Const.PASSWORD_SECRET}$password';
  }

  static String passwordDecrypt(String passwordEncypted) {
    if (passwordEncypted == null) return '';
    return passwordEncypted.replaceFirst(Const.PASSWORD_SECRET, '');
  }

  static void savePassword(String email, String password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(Utils.keyUserName(email), Utils.passwordEncrypt(password));
  }

  static void clearPassword(String email, String password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(Utils.keyUserName(email));
  }

  static getSavedPassword(String email) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String encryptedPassword = _prefs.getString(Utils.keyUserName(email));
    return passwordDecrypt(encryptedPassword);
  }

  static String getInvoiceId(String invoiceNumber) {
    if (Utils.isEmpty(invoiceNumber)) return "";
    String invoiceId = "B";
    invoiceId += DateTime.now().year.toString();
    int numInvoiceId = int.parse(invoiceNumber) + 100;
    invoiceId += numInvoiceId.toString();

    return invoiceId;
  }

  static String getOrderStatus(BuildContext context, String status) {
    switch (status) {
      case Const.STATUS_PENDING:
        return S.of(context).status_pending;
      case Const.STATUS_SUBMITTED:
        return S.of(context).status_submitted;
      case Const.STATUS_CONFIRMED:
        return S.of(context).status_confirmed;
      case Const.STATUS_STARTING:
        return S.of(context).status_starting;
      case Const.STATUS_WAITING:
        return S.of(context).status_waiting;
      case Const.STATUS_COMPLETED:
        return S.of(context).status_completed;
      case Const.STATUS_PROCESSING:
        return S.of(context).status_processing;
      case Const.STATUS_CANCELLED:
        return S.of(context).status_canceled;
    }
    return S.of(context).status_waiting;
  }

  static Color getColorOrderStatus(String status) {
    switch (status) {
      case Const.STATUS_PENDING:
        return blue;
      case Const.STATUS_SUBMITTED:
        return blue;
      case Const.STATUS_CONFIRMED:
        return greenAccent;
      case Const.STATUS_STARTING:
        return greenAccent;
      case Const.STATUS_WAITING:
        return blue;
      case Const.STATUS_COMPLETED:
        return blue_100;
      case Const.STATUS_PROCESSING:
        return greenAccent;
      case Const.STATUS_CANCELLED:
        return red;
    }
    return blue_100;
  }

  static String getPaymentStatus(BuildContext context, String status) {
    switch (status) {
      case Const.PAYMENT_PAID:
        return S.of(context).payment_paid;
      case Const.PAYMENT_NOT_PAID:
        return S.of(context).payment_not_paid;
      case Const.STATUS_APPROVE:
        return S.of(context).approve;
    }
    return S.of(context).payment_not_paid;
  }

  static Color getColorPaymentStatus(String status) {
    switch (status) {
      case Const.PAYMENT_PAID:
        return blue;
      case Const.PAYMENT_NOT_PAID:
        return redAccent;
      case Const.STATUS_APPROVE:
        return greenAccent;
    }
    return redAccent;
  }

  static Future<DateTime> selectDate(BuildContext context,
      {DateTime initDate, DateTime lastDate}) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: initDate ?? DateTime.now(),
        firstDate:
            (initDate ?? DateTime.now()).subtract(Duration(days: 30 * 12)),
        lastDate: lastDate ?? DateTime.now().add(Duration(days: 30 * 12)));
    return picked;
  }

  static int convertPriceToNumber(String price) {
    if (price == null) return null;
    String newPrice = price
        .replaceAll(" ", "")
        .replaceAll("đ", "")
        .replaceAll("₫", "")
        .replaceAll("\$", "")
        .replaceAll(",", "");
    try {
      return int.parse(newPrice);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  static String formatMoney(dynamic amount) {
    if (amount == null) return null;
    if (amount is String) {
      amount = double.parse(amount);
    }
    return NumberFormat("#,##0 ₫").format(amount);
  }

  static void showToast(String text) {
    if (!isEmpty(text))
      Fluttertoast.showToast(
        msg: text ?? "",
        backgroundColor: blue_100,
      );
  }

  static void showForegroundNotification(
      BuildContext context, String title, String text,
      {VoidCallback onTapNotification}) {
    showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          bottom: false,
          child: InkWell(
            onTap: () {
              OverlaySupportEntry.of(context).dismiss();
              onTapNotification();
            },
            child: ListTile(
              leading: SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: ClipOval(
                    child: Image.asset(icLogo),
                  )),
              title: Text(
                title ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, color: black),
              ),
              subtitle: Text(
                text ?? "",
                style: TextStyle(color: grey),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.close, color: grey),
                  onPressed: () {
                    OverlaySupportEntry.of(context).dismiss();
                  }),
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 4000));
  }

  static String getFileName(File file) {
    return basename(file.path);
  }

  static String base64Image(File file) {
    if (file == null) return null;
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static void saveAppointment(SharedPreferences _pref, CaseData caseData) {
    if (Utils.isEmpty(caseData)) return;
  }

  static void saveUser(SharedPreferences _pref, User user) {
    if (user == null) return;
    String token = user.token;
    String fullName = user.name;
    String avatar = user.avatarUrl;
    String id = user.id;
    _pref.setString(Const.TOKEN, id);
    _pref.setString(Const.FULL_NAME, fullName);
    _pref.setString(Const.AVATAR, avatar);
    _pref.setString(Const.DEVICE_TOKEN, token);
  }

//  static void saveData(SharedPreferences _pref, LoginData responseData) {
//    if (responseData == null) return;
//    String token = responseData.authorization;
//    String refreshToken = responseData.refreshToken;
//    int id = responseData.id;
//    String fullName = responseData.fullName;
//    String email = responseData.email;
//    String phoneNumber = responseData.phoneNumber;
//    String jobTitle = responseData.jobTitle;
//    String avatar = responseData.picture;
//    String introduce = responseData.about;
//    BillingAddress billingAddress;
//    List<BillingAddress> listAddress = responseData.address;
//    if (!Utils.isEmpty(listAddress)) billingAddress = listAddress[0];
//    String address, city, district, state;
//    if (billingAddress != null) {
//      address = billingAddress.address1;
//      city = billingAddress.city;
//      district = billingAddress.district;
//      state = billingAddress.ward;
//    }
//
//    if (!isEmpty(token)) _pref.setString(Const.TOKEN, token);
//    if (!isEmpty(refreshToken))
//      _pref.setString(Const.REFRESH_TOKEN, refreshToken);
//    _pref.setInt(Const.ID, id);
//    _pref.setString(Const.EMAIL, email);
//    _pref.setString(Const.FULL_NAME, fullName);
//    _pref.setString(Const.PHONE, phoneNumber);
//    _pref.setString(Const.AVATAR, avatar);
//    _pref.setString(Const.JOB_TITLE, jobTitle);
//    _pref.setString(Const.ADDRESS, address);
//    _pref.setString(Const.CITY, city);
//    _pref.setString(Const.STATE, state);
//    _pref.setString(Const.DISTRICT, district);
//    _pref.setString(Const.INTRODUCE, introduce);
//  }

  static void clearData(SharedPreferences _pref) {
    _pref.remove(Const.REFRESH_TOKEN);
    _pref.remove(Const.TOKEN);
    _pref.remove(Const.ID);
    _pref.remove(Const.FULL_NAME);
    _pref.remove(Const.PHONE);
    _pref.remove(Const.AVATAR);
    _pref.remove(Const.JOB_TITLE);
    _pref.remove(Const.ADDRESS);
    _pref.remove(Const.CITY);
    _pref.remove(Const.DISTRICT);
  }

  static bool isShowAll(int index) {
    return index < 1;
  }

  static String convertVNtoText(String str) {
    str = str.replaceAll(RegExp(r'[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');

    str = str.replaceAll(RegExp(r'[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ì|í|ị|ỉ|ĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');

    str = str.replaceAll(RegExp(r'[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    str = str.replaceAll(RegExp(r'[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    str = str.replaceAll(RegExp(r'[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    str = str.replaceAll(RegExp(r'[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    str = str.replaceAll(RegExp(r'[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    str = str.replaceAll(RegExp(r'[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    str = str.replaceAll(RegExp(r'[Đ]'), 'D');
    return str;
  }
}
