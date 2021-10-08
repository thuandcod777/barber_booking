import 'package:barber_booking/model/phone_auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthFirebaseProvider {
  final FirebaseAuth _firebaseAuth;
  String? verificationId;

  PhoneAuthFirebaseProvider({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required verificationCompleted,
      required verificationFailed,
      required codeSent,
      required codeAutoRetrievalTimeout}) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration(seconds: 30));
  }

  Future<User?> loginWithSMSVerificationCode(
      {required String verificationId,
      required String smsVerficationcode}) async {
    final AuthCredential credential = _getAuthCredentialFromVerificationCode(
        verificationId: verificationId, verificationCode: smsVerficationcode);

    return await authenticationWithCredential(credential: credential);
  }

  Future<User?> authenticationWithCredential(
      {required AuthCredential credential}) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  AuthCredential _getAuthCredentialFromVerificationCode(
      {required String verificationId, required verificationCode}) {
    return PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: verificationCode);
  }

  

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
