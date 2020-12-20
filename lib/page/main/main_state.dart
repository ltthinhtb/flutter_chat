import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  MainState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialMainState extends MainState {
  @override
  String toString() {
    return 'InitialMainState{}';
  }
}

class MainPageState extends MainState {
  final int position;

  MainPageState(this.position);

  @override
  String toString() => 'MainPageState';
}

class MainFailure extends MainState {
  final String error;

  MainFailure(this.error);

  @override
  String toString() {
    return 'MainFail{error: $error}';
  }
}

class MainProfile extends MainState {
  @override
  String toString() => 'MainProfile';
}

class MainLoading extends MainState {
  @override
  String toString() => "MainLoading";
}


class ChangeTitleAppbarSuccess extends MainState {
  final String title;

  ChangeTitleAppbarSuccess({this.title}) : super([title]);

  @override
  String toString() {
    return 'ChangeTitleAppbarSuccess{title: $title}';
  }
}

class CountNotificationState extends MainState {
  final int count;

  CountNotificationState(this.count);

  @override
  String toString() {
    return 'CountNotificationState{count: $count}';
  }
}

class RefreshMainSuccess extends MainState {
  @override
  String toString() {
    return 'RefreshMainSuccess{}';
  }
}

class RefreshAfterLoginSuccess extends MainState {
  @override
  String toString() {
    return 'RefreshAfterLoginSuccess{}';
  }
}

class NavigateToNotificationState extends MainState {

  @override
  String toString() {
    return 'NavigateToNotificationState{}';
  }
}

class GetNewNotificationSuccess extends MainState {

  final int orderId;

  GetNewNotificationSuccess(this.orderId);

  @override
  String toString() {
    return 'GetNewNotificationSuccess {orderId : $orderId}';
  }
}