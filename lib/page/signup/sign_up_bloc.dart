import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vn_dental/models/network/response/district_response.dart';
import 'package:vn_dental/models/service/network_factory.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/log.dart';
import 'package:vn_dental/utils/utils.dart';
import 'package:vn_dental/utils/validator.dart';

import 'sign_up.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with Validators {
  NetworkFactory _networkFactory;
  String errorName;
  String errorEmail;
  String errorPassword;
  String errorConfirmPassword;
  String errorPhone;
  String selectedGender;
  String selectCity;
  String selectDistrict;
  DateTime birthday;
  List<DistrictResponse> district  = List();
  List<String> listCity = ["Hà Nội"];
  List<String> gender = [Const.MALE, Const.FEMALE];

  BuildContext context;
  SignUpBloc(this.context) : super(SignUpInitial()){
    _networkFactory = NetworkFactory(context);
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // TODO: implement mapEventToState
    if(event is GetDistrict){
      yield SignUpLoading();
      _handListDistrict(await _networkFactory.getDistrict());
    }
    if (event is SignUpByEmail) {
      String name = event.name;
      String email = event.email;
      String password = event.password;
      String rePassword = event.rePassword;
      String errorName = checkName(context, name);
      if (!Utils.isEmpty(errorName)) {
        yield SignUpFailure(errorName);
        return;
      }
      String errorEmail = checkEmail(context, email);
      if (!Utils.isEmpty(errorEmail)) {
        yield SignUpFailure(errorEmail);
        return;
      }
      String errorPass = checkPass(context, password);
      if (!Utils.isEmpty(errorPass)) {
        yield SignUpFailure(errorPass);
        return;
      }
      String errorRePass = checkRePass(context, password, rePassword);
      if (!Utils.isEmpty(errorRePass)) {
        yield SignUpFailure(errorRePass);
        return;
      }
      yield SignUpLoading();
      yield state;
    } else if (event is ValidateName) {
      yield SignUpInitial();
      errorName = checkName(context, event.name);
      yield ValidateError();
    } else if (event is ValidatePhone) {
      yield SignUpInitial();
      errorPhone = checkPhoneNumber(context, event.phone);
      yield ValidateError();
    } else if (event is ValidateEmail) {
      yield SignUpInitial();
      errorEmail = checkEmail(context, event.email);
      yield ValidateError();
    } else if (event is SelectGender) {
      yield SignUpLoading();
      selectedGender = event.gender;
      yield SignUpInitial();
    } else if (event is SelectBirthDay) {
      yield SignUpLoading();
      birthday = event.date;
      yield SignUpInitial();
    } else if (event is ValidatePass) {
      yield SignUpInitial();
      errorPassword = checkPass(context, event.pass);
      yield ValidateError();
    } else if (event is ValidateRePass) {
      yield SignUpInitial();
      errorConfirmPassword = checkRePass(context, event.pass, event.rePass);
      yield ValidateError();
    } else if (event is SignUpResetStateEvent) yield SignUpResetStateState();
  }
  void _handListDistrict(Object data) {
    if (data is String) return;
    try {
      if (data is List) {
        district = data.map((e) => DistrictResponse.fromJson(e)).toList();
      }
    } catch (e) {
      logger.e(toString());
    }
  }

}
