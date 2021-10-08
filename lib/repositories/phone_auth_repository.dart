import 'package:barber_booking/model/phone_auth_model.dart';
import 'package:barber_booking/provider/phone_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthFirebaseRepository {
  final PhoneAuthFirebaseProvider _phoneAuthProvider;

  PhoneAuthFirebaseRepository(
      {required PhoneAuthFirebaseProvider phoneAuthProvider})
      : _phoneAuthProvider = phoneAuthProvider;

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required verificationCompleted,
      required verificationFailed,
      required codeSent,
      required codeAutoRetrievalTimeout}) async {
    await _phoneAuthProvider.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<PhoneAuthModel> verifySMSCode({
    required String smsCode,
    required String verificationId,
  }) async {
    final User? user = await _phoneAuthProvider.loginWithSMSVerificationCode(
        verificationId: verificationId, smsVerficationcode: smsCode);

    if (user != null) {
      return PhoneAuthModel(
          phoneAuthModelState: PhoneAuthModelState.verified, uid: user.uid);
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }

  Future<PhoneAuthModel> verifyWithCredential({
    required AuthCredential credential,
  }) async {
    final User? user = await _phoneAuthProvider.authenticationWithCredential(
        credential: credential);

    if (user != null) {
      return PhoneAuthModel(
          phoneAuthModelState: PhoneAuthModelState.verified, uid: user.uid);
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }
}
