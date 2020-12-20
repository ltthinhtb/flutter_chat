import 'package:equatable/equatable.dart';

abstract class MessageDetailState extends Equatable {
  MessageDetailState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitMessageDetailState extends MessageDetailState {
  @override
  String toString() {
    return 'InitMessageDetailState{}';
  }
}

class MessageDetailLoading extends MessageDetailState {
  @override
  String toString() {
    return 'MessageDetailLoading{}';
  }
}

class LoadMessageDetailSuccess extends MessageDetailState {
  @override
  String toString() {
    return 'LoadMessageDetailSuccess{}';
  }
}

class SendMessageSuccess extends MessageDetailState {
  @override
  String toString() {
    return 'SendMessageSuccess{}';
  }
}

class SendMessageFailure extends MessageDetailState {
  @override
  String toString() {
    return 'SendMessageFailure{}';
  }
}

class DeleteMessageSuccess extends MessageDetailState {
  @override
  String toString() {
    return 'DeleteMessageSuccess{}';
  }
}
