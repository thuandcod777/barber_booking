import 'dart:io';

import 'package:barber_booking/config/path.dart';
import 'package:barber_booking/model/users.dart';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:barber_booking/utils/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataProvider extends BaseUserDataProvider {
  final FirebaseFirestore _firebaseStore;
  final FirebaseAuth _firebaseAuth;

  UserDataProvider(
      {FirebaseFirestore? firebaseStore, FirebaseAuth? firebaseAuth})
      : _firebaseStore = firebaseStore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UsersModel> saveProfileUser(
      String photo, String name, String email, String address) async {
    String? uid = _firebaseAuth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> ref =
        _firebaseStore.collection(Paths.usersPath).doc(uid);

    var data = {
      'uid': uid,
      'photoUrl': photo,
      'username': name,
      'email': email,
      'address': address
    };

    ref.set(data, SetOptions(merge: true));

    final DocumentSnapshot<Map<String, dynamic>> currentDocument =
        await ref.get();

    return UsersModel.fromMap(currentDocument);
  }

  @override
  Future<UsersModel> getUser() async {
    String? uid = _firebaseAuth.currentUser!.uid;
    DocumentReference<Map<String, dynamic>> ref =
        await _firebaseStore.collection(Paths.usersPath).doc(uid);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await ref.get();

    if (snapshot.exists) {
      return UsersModel.fromMap(snapshot);
    } else {
      throw UserNotFoundException();
    }
  }

  Future<bool> isFirstTime(String userId) async {
    bool? exist;
    await _firebaseStore
        .collection(Paths.usersPath)
        .doc(userId)
        .get()
        .then((user) {
      exist = user.exists;
    });

    return exist!;
  }

  /*Stream<GeoLocation> getLocation(String? location) async* {
    Position position;
    Placemark placemark;
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      print(permission);
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      placemark = placemarks[0];
      String location = "${placemarks[0].locality},${placemarks[0].country}";
      //locationTEC.text = location;

      print(location);
    }
  }*/
}
