part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonClickedEvent({required this.email, required this.password});
}

class LoginStateChangeEvent extends LoginEvent {}

class LoginResetClickedEvent extends LoginEvent {
  final String email;

  LoginResetClickedEvent({required this.email});
}
