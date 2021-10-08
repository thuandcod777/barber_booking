part of 'phoneauth_bloc.dart';

abstract class PhoneauthState extends Equatable {
  const PhoneauthState();

  @override
  List<Object?> get props => [];
}

class PhoneauthInitial extends PhoneauthState {}

class PhoneauthLoading extends PhoneauthState {}

class PhoneauthError extends PhoneauthState {}

class PhoneAuthNumberVerficationFailure extends PhoneauthState {
  final String message;
  PhoneAuthNumberVerficationFailure(this.message);

  @override
  List<Object> get props => [props];
}

class PhoneAuthNumberVerficationSuccess extends PhoneauthState {
  final String verificationId;
  PhoneAuthNumberVerficationSuccess({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthCodeVerficationFailure extends PhoneauthState {
  final String message;
  final String verificationId;
  PhoneAuthCodeVerficationFailure(this.message, this.verificationId);

  @override
  List<Object> get props => [message];
}

class PhoneAuthCodeVerficationSuccess extends PhoneauthState {
  final String? uid;
  PhoneAuthCodeVerficationSuccess({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class PhoneAuthCodeAutoRetrevalTimeoutComplete extends PhoneauthState {
  final String verificationId;
  PhoneAuthCodeAutoRetrevalTimeoutComplete(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}
