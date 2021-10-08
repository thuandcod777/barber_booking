part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends SigninEvent {
  final String? email;

  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];

  String toString() => 'EmailChanged: {email:$email}';
}

class PasswordChanged extends SigninEvent {
  final String? password;

  PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  String toString() => 'PasswordChanged: {password:$password}';
}

class Submmited extends SigninEvent {
  final String? email;
  final String? password;

  Submmited(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class SignUpWithCredentialsPressed extends SigninEvent {
  final String? email;
  final String? password;

  SignUpWithCredentialsPressed(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}
