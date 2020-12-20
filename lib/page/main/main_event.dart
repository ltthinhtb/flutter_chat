import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  MainEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NavigateBottomNavigation extends MainEvent {
  final int position;

  NavigateBottomNavigation(this.position);

  @override
  String toString() => 'NavigateBottomNavigation: $position';
}

class NavigateProfile extends MainEvent {
  @override
  String toString() => 'NavigateProfile';
}

class ChangeAuthorizationEvent extends MainEvent {
  @override
  String toString() => 'ChangeAuthorizationEvent';
}

class GetCountNotification extends MainEvent {
  @override
  String toString() {
    return 'GetCountNotification{}';
  }
}

class NewNotificationEvent extends MainEvent {
  final int orderId;

  NewNotificationEvent(this.orderId);

  @override
  String toString() {
    return 'NewNotificationEvent {orderId: $orderId}';
  }
}

class GetCountShoppingProductEvent extends MainEvent {
  @override
  String toString() {
    return 'GetCountShoppingProductEvent{}';
  }
}

class MainStart extends MainEvent {
  @override
  String toString() {
    return 'MainStart{}';
  }
}
