import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable {
  SettingState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SettingFailure extends SettingState {
  final String error;

  SettingFailure(this.error);

  @override
  String toString() => 'SettingFailure { error: $error }';
}

class SettingLoading extends SettingState {
  @override
  String toString() => 'SettingLoading';
}

class SettingInitial extends SettingState {
  @override
  String toString() => 'SettingInitial';
}

class RefreshSettingSuccess extends SettingState {
  @override
  String toString() {
    return 'RefreshSettingSuccess{}';
  }
}

class LogoutSuccess extends SettingState {
  @override
  String toString() {
    return 'LogoutSuccess{}';
  }
}
