part of 'phoneauth_bloc.dart';

abstract class PhoneauthEvent extends Equatable {
  const PhoneauthEvent();

  @override
  List<Object?> get props => [];
}

class PhoneAuthNumberVerified extends PhoneauthEvent {
  final String phoneNumber;

  PhoneAuthNumberVerified({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneAuthCodeVerified extends PhoneauthEvent {
  final String verificationId;
  final String smsCode;

  PhoneAuthCodeVerified({required this.verificationId, required this.smsCode});

  @override
  List<Object> get props => [smsCode];
}

class PhoneAuthCodeAutoRetrevalTimeout extends PhoneauthEvent {
  final String verificationId;

  PhoneAuthCodeAutoRetrevalTimeout(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthCodeSend extends PhoneauthEvent {
  final String verificationId;
  final int? token;

  PhoneAuthCodeSend({required this.verificationId, required this.token});

  @override
  List<Object?> get props => [verificationId];
}

class PhoneAuthVerificationFailed extends PhoneauthEvent {
  final String message;

  PhoneAuthVerificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class PhoneAuthVerificationCompleted extends PhoneauthEvent {
  final String? uid;

  PhoneAuthVerificationCompleted(this.uid);

  @override
  List<Object?> get props => [uid];
}
