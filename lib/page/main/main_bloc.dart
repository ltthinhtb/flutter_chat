import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  BuildContext context;
  SharedPreferences _prefs;
  int _prePosition = 0;

  int get prePosition => _prePosition;


  MainBloc(this.context) : super(InitialMainState()) ;

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    if (event is NavigateBottomNavigation) {
      int position = event.position;
      if (state is MainPageState) {
        if (_prePosition == position) return;
      }
      _prePosition = position;
      yield MainLoading();
      yield MainPageState(position);
    }
    if (event is ChangeAuthorizationEvent) {
      yield InitialMainState();
      yield RefreshAfterLoginSuccess();
    }
  }
}
