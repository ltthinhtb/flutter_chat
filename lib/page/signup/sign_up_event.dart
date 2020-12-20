import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpByEmail extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String rePassword;

  SignUpByEmail(this.name, this.email, this.password, this.rePassword);

  @override
  String toString() =>
      'SignUpByEmail { name: $name, email: $email, password: $password, RePassword: $rePassword}';
}

class ValidateName extends SignUpEvent {
  final String name;

  ValidateName(this.name);

  @override
  String toString() => 'ValidateName { name: $name }';
}

class ValidateEmail extends SignUpEvent {
  final String email;

  ValidateEmail(this.email);

  @override
  String toString() => 'ValidateEmail { email: $email }';
}

class ValidatePass extends SignUpEvent {
  final String pass;

  ValidatePass(this.pass);

  @override
  String toString() => 'ValidatePass { pass: $pass }';
}

class ValidatePhone extends SignUpEvent {
  final String phone;

  ValidatePhone(this.phone);

  @override
  String toString() {
    return 'ValidatePhone{phone: $phone}';
  }
}

class ValidateRePass extends SignUpEvent {
  final String pass;
  final String rePass;

  ValidateRePass(this.pass, this.rePass);

  @override
  String toString() => 'ValidateRePass { pass: $pass, RePass: $rePass }';
}

class SignUpResetStateEvent extends SignUpEvent {
  @override
  String toString() {
    return 'SignUpResetStateEvent{}';
  }
}

class SelectGender extends SignUpEvent {
  final String gender;

  @override
  String toString() {
    return 'SelectGender{gender: $gender}';
  }

  SelectGender(this.gender);
}

class SelectBirthDay extends SignUpEvent {
  final DateTime date;

  SelectBirthDay(this.date);

  @override
  String toString() {
    return 'SelectBirthDay{date: $date}';
  }
}

class GetDistrict extends SignUpEvent{

  @override
  String toString() {
    return 'GetDistrict{}';
  }
}