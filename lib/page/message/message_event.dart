import 'package:equatable/equatable.dart';
import 'package:vn_dental/models/network/response/user.dart';

abstract class MessageEvent extends Equatable {
  MessageEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SelectDoctor extends MessageEvent {
  final User doctorData;

  SelectDoctor(this.doctorData);

  @override
  String toString() {
    return 'SelectDoctor{doctorData: $doctorData}';
  }
}

class RefreshChatLogin extends MessageEvent {
  @override
  String toString() {
    return 'NavigatorChatDetail{}';
  }
}

class GetListDoctor extends MessageEvent {
  final bool isRefresh;
  final String userID;

  GetListDoctor({this.isRefresh, this.userID});

  @override
  String toString() {
    return 'GetListDoctor{}';
  }
}


