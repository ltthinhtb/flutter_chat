import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginByEmail extends LoginEvent {
  final String email;
  final String password;

  LoginByEmail(this.email, this.password);

  @override
  String toString() => 'LoginByEmail { email: $email, password: $password }';
}

class ValidateEmail extends LoginEvent {
  final String email;

  ValidateEmail(this.email);

  @override
  String toString() => 'ValidateEmail { email: $email }';
}

class ValidatePass extends LoginEvent {
  final String pass;

  ValidatePass(this.pass);

  @override
  String toString() => 'ValidatePass { pass: $pass }';
}

class LoginFacebook extends LoginEvent {
  @override
  String toString() => 'LoginFacebook';
}

class LoginGoogle extends LoginEvent {
  @override
  String toString() => 'LoginGoogle';
}

class LoginApple extends LoginEvent {
  @override
  String toString() {
    return 'LoginApple{}';
  }
}
