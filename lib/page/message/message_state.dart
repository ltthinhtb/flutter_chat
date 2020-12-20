import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  MessageState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitMessageState extends MessageState {
  @override
  String toString() {
    return 'InitMessageState{}';
  }
}

class MessageLoading extends MessageState {
  @override
  String toString() {
    return 'MessageLoading{}';
  }
}

class MessageLogin extends MessageState {
  @override
  String toString() {
    return 'MessageLogin{}';
  }
}

class MessageLoginSuccess extends MessageState {
  @override
  String toString() {
    return 'MessageLoginSuccess{}';
  }
}

class LoadDoctorSuccess extends MessageState {
  @override
  String toString() {
    return 'LoadDoctorSuccess{}';
  }
}
