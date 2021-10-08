part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userId;

  Authenticated(this.userId);

  @override
  List<Object?> get props => [userId];

  @override
  String toString() => "Authenticated {$userId}";
}

class AuthenticatedButNotSet extends AuthenticationState {
  final String userId;

  AuthenticatedButNotSet(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UnAuthentication extends AuthenticationState {}
