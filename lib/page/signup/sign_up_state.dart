import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  SignUpState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {
  @override
  String toString() => 'SignUpInitial';
}

class SignUpLoading extends SignUpState {
  @override
  String toString() => 'SignUpLoading';
}

class ValidateError extends SignUpState {
  @override
  String toString() => 'ValidateErrorName { error:  }';
}

class SignUpSuccess extends SignUpState {
  final String message;

  SignUpSuccess(this.message);

  @override
  String toString() => 'SignUpSuccess { message: $message }';
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  String toString() => 'SignUpFailure { error: $error }';
}

class SignUpResetStateState extends SignUpState {
  @override
  String toString() {
    return 'SignUpResetStateState{}';
  }
}


