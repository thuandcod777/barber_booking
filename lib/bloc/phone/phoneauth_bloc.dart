import 'dart:async';

import 'package:barber_booking/model/phone_auth_model.dart';
import 'package:barber_booking/repositories/phone_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phoneauth_event.dart';
part 'phoneauth_state.dart';

class PhoneauthBloc extends Bloc<PhoneauthEvent, PhoneauthState> {
  final PhoneAuthFirebaseRepository _phoneAuthRepository;

  PhoneauthBloc({required PhoneAuthFirebaseRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository,
        super(PhoneauthInitial());

  @override
  Stream<PhoneauthState> mapEventToState(
    PhoneauthEvent event,
  ) async* {
    if (event is PhoneAuthNumberVerified) {
      yield* _phoneAuthNumberVerficationToState(event);
    } else if (event is PhoneAuthCodeAutoRetrevalTimeout) {
      yield PhoneAuthCodeAutoRetrevalTimeoutComplete(event.verificationId);
    } else if (event is PhoneAuthCodeSend) {
      yield PhoneAuthNumberVerficationSuccess(
          verificationId: event.verificationId);
    } else if (event is PhoneAuthVerificationFailed) {
      yield PhoneAuthNumberVerficationFailure(event.message);
    } else if (event is PhoneAuthVerificationCompleted) {
      yield PhoneAuthCodeVerficationSuccess(uid: event.uid);
    } else if (event is PhoneAuthCodeVerified) {
      yield* _phoneAuthCodeVerifiedToState(event);
    }
  }

  Stream<PhoneauthState> _phoneAuthNumberVerficationToState(
      PhoneAuthNumberVerified event) async* {
    try {
      yield PhoneauthLoading();
      await _phoneAuthRepository.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: _onCodeSent,
          codeAutoRetrievalTimeout: _onCodeAutoRetrevalTimeOut);
    } on Exception catch (e) {}
  }

  Stream<PhoneauthState> _phoneAuthCodeVerifiedToState(
      PhoneAuthCodeVerified event) async* {
    try {
      yield PhoneauthLoading();
      PhoneAuthModel phoneAuthModel = await _phoneAuthRepository.verifySMSCode(
          smsCode: event.smsCode, verificationId: event.verificationId);
      yield PhoneAuthCodeVerficationSuccess(uid: phoneAuthModel.uid);
    } on Exception catch (e) {
      print('Excpetion occured while verifying OTP code ${e.toString()}');
      yield PhoneAuthCodeVerficationFailure(e.toString(), event.verificationId);
    }
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    final PhoneAuthModel phoneAuthModel =
        await _phoneAuthRepository.verifyWithCredential(credential: credential);

    if (phoneAuthModel.phoneAuthModelState == PhoneAuthModelState.verified) {
      add(PhoneAuthVerificationCompleted(phoneAuthModel.uid));
    }
  }

  void _onVerificationFailed(FirebaseException exception) {
    print(
        'Exception has occured while verifying phone number: ${exception.toString()}');

    add(PhoneAuthVerificationFailed(exception.toString()));
  }

  void _onCodeSent(String verificationId, int? token) {
    print(
        'Print code is successfully sent with verification id $verificationId and token $token');

    add(PhoneAuthCodeSend(verificationId: verificationId, token: token));
  }

  void _onCodeAutoRetrevalTimeOut(String verificationId) {
    print('Auto retrieval has timed out for verification ID $verificationId');
    add(PhoneAuthCodeAutoRetrevalTimeout(verificationId));
  }
}
