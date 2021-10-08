import 'dart:io';

import 'package:barber_booking/model/users.dart';
import 'package:barber_booking/provider/authentication_provider.dart';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider =
      AuthenticationFirebaseProvider();

  Future<User?> loginGoogle() => authenticationProvider.loginGoogle();

  Future<String> getCurrentUser() => authenticationProvider.getCurrentUser();

  Future<void> signUpWithEmail(
          {required String email, required String password}) =>
      authenticationProvider.signUpWithEmail(email: email, password: password);

  Future<UserCredential?> signInWithEmail(String email, String password) =>
      authenticationProvider.signInWithEmail(email, password);

  Future<void> signOut() => authenticationProvider.signOut();

  Future<bool> isSignedIn() => authenticationProvider.isSignedIn();
}
