import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() {
    return 'AppStarted{}';
  }
}

class LogOut extends AuthenticationEvent {
  @override
  String toString() {
    return 'LogOut{}';
  }
}

class LogIn extends AuthenticationEvent {
  @override
  String toString() {
    return 'LogIn{}';
  }
}


