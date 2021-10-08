import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String? uid;
  final String? email;
  final String? username;
  final String? password;
  final String? photo;
  final String? address;

  UsersModel(
      {this.uid,
      this.email,
      this.username,
      this.password,
      this.photo,
      this.address});

  factory UsersModel.fromMap(DocumentSnapshot<Map<String, dynamic>>? map) {
    return UsersModel(
        uid: map?['uid'],
        email: map?['email'],
        username: map?['username'],
        password: map?['password'],
        photo: map?['photo'],
        address: map?['address']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'password': password,
      'photo': photo,
      'address': address
    };
  }
}
