import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationInitial{}';
  }
}


class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationLoading{}';
  }
}

class Authenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Authenticated{}';
  }
}

class UnAuthentication extends AuthenticationState {
  @override
  String toString() {
    return 'UnAuthentication{}';
  }
}
