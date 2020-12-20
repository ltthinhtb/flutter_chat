import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  String toString() {
    return 'InitLoginState{}';
  }
}

class LoginLoading extends LoginState {
  @override
  String toString() {
    return 'LoginLoading{}';
  }
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ValidateError extends LoginState {
  @override
  String toString() {
    return 'ValidateError{}';
  }
}


class LoginSuccess extends LoginState {

  @override
  String toString() {
    return 'LoginSuccess{}';
  }
}