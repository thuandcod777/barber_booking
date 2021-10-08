import 'dart:io';

import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/model/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthenticationProvider {
  Future<User?> loginGoogle();
  Future<void> signUpWithEmail({String email, String password});
  Future<UserCredential?> signInWithEmail(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
  Future<bool> isSignedIn();
}

abstract class BaseUserDataProvider {
  Future<UsersModel> saveProfileUser(
      String photo, String name, String email, String address);
  Future<UsersModel> getUser();

  Future<bool> isFirstTime(String userId);
}

abstract class BaseDataTruckProvider {
  Stream<List<TruckModel>> getListTrucks();

  // Future<List<TruckModel>> getListTrucks();
}

abstract class BaseStorageProvider {
  Future<String> uploadImage(File file, String path);
}
