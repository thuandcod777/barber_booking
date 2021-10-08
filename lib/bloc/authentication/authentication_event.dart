part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LogginIn extends AuthenticationEvent {}

class LogginOut extends AuthenticationEvent {}
