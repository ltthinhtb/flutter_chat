import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/models/service/auth_service.dart';
import 'package:vn_dental/page/setting/setting.dart';
import 'package:vn_dental/utils/utils.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  BuildContext context;
  AuthService _authService;
  SharedPreferences _pref;

  SettingBloc() : super(SettingInitial()) {
    _authService = AuthService(context);
  }

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
    if (event is RefreshSetting) {
      yield SettingLoading();
      yield RefreshSettingSuccess();
    }
    if (event is LogOutEvent) {
      yield SettingLoading();
      await _authService.logOut();
      Utils.clearData(_pref);
      yield LogoutSuccess();
    }
  }
}
