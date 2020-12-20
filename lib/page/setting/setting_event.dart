import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  SettingEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogOutEvent extends SettingEvent {
  @override
  String toString() {
    return 'LogOutEvent{}';
  }

}

class RefreshSetting extends SettingEvent {
  @override
  String toString() {
    return 'RefreshSetting{}';
  }
}

