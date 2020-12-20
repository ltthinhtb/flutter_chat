import 'package:flutter/material.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/utils/utils.dart';


class Validators {
  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String checkPhoneNumber(BuildContext context, String phoneNumber) {
    if (Utils.isEmpty(phoneNumber)) {
      return S.of(context).please_input_phone_number;
    } else if (!_phoneRegex.hasMatch(phoneNumber)) {
      return S.of(context).phone_not_valid;
    } else {
      return null;
    }
  }

  String checkPhoneNumber2(BuildContext context, String phoneNumber) {
    if (Utils.isEmpty(phoneNumber)) return null;
    if (!_phoneRegex.hasMatch(phoneNumber)) {
      return S.of(context).phone_not_valid;
    } else {
      return null;
    }
  }

  String checkEmail(BuildContext context, String email) {
    if (Utils.isEmpty(email)) {
      return S.of(context).please_input_email;
    } else if (!_emailRegex.hasMatch(email)) {
      return S.of(context).email_not_valid;
    } else {
      return null;
    }
  }

  String checkEmail2(BuildContext context, String email) {
    if (Utils.isEmpty(email)) return null;
    if (!_emailRegex.hasMatch(email)) {
      return S.of(context).email_not_valid;
    } else {
      return null;
    }
  }

  String checkPass(BuildContext context, String password) {
    if (Utils.isEmpty(password)) {
      return S.of(context).please_enter_password;
    } else if (password.length < 4) {
      return S.of(context).password_least_character;
    } else {
      return null;
    }
  }

  String checkCurrentPass(BuildContext context, String password) {
    if (Utils.isEmpty(password)) {
      return S.of(context).please_enter_curr_password;
    } else if (password.length < 4) {
      return S.of(context).password_least_character;
    } else {
      return null;
    }
  }

  String checkNewPass(
      BuildContext context, String oldPassword, String newPassword) {
    if (Utils.isEmpty(newPassword)) {
      return S.of(context).please_enter_new_password;
    } else if (newPassword.length < 4) {
      return S.of(context).password_least_character;
    } else if (newPassword == oldPassword) {
      return S.of(context).cannot_same_current_password;
    } else {
      return null;
    }
  }

  String checkConfirmPass(
      BuildContext context, String password, String rePassword) {
    if (Utils.isEmpty(rePassword)) {
      return S.of(context).please_input_re_password;
    } else if (rePassword.length < 4) {
      return S.of(context).password_least_character;
    } else if (password != rePassword) {
      return S.of(context).password_not_match;
    } else {
      return null;
    }
  }

  String checkRePass(BuildContext context, String password, String rePassword) {
    if (Utils.isEmpty(rePassword)) {
      return S.of(context).please_input_re_password;
    } else if (rePassword.length < 4) {
      return S.of(context).password_least_character;
    } else if (password != rePassword) {
      return S.of(context).password_not_match;
    } else {
      return null;
    }
  }

  String checkRePass2(BuildContext context, String password) {
    if (Utils.isEmpty(password)) {
      return S.of(context).please_input_re_password;
    } else if (password.length < 4) {
      return S.of(context).password_least_character;
    } else {
      return null;
    }
  }

  String checkName(BuildContext context, String name) {
    if (Utils.isEmpty(name)) return S.of(context).please_input_username;
//    else if (name.length < 5)
//      return S.of(context).name_least_character;
//    else if (name.length > 50) return S.of(context).name_too_many_characters;
    return null;
  }
}
