import 'dart:io';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider extends BaseStorageProvider {
  final FirebaseStorage _firebaseStorage;

  StorageProvider({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> uploadImage(File file, String path) async {
    String fileName = basename(file.path);
    final miliSecs = DateTime.now().millisecondsSinceEpoch;
    Reference reference =
        _firebaseStorage.ref().child('$path/$miliSecs\_$fileName');
    String uploadPath = reference.toString();
    print('uploading to $uploadPath');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot result = await uploadTask;
    String url = await result.ref.getDownloadURL();
    print(url);

    return url;
  }

  /*Future<String> uploadImage(File file, String path) async {
    String fileName = basename(file.path);
    // final miliSecs = DateTime.now().millisecondsSinceEpoch;
    var timeStamp = Timestamp.now().microsecondsSinceEpoch;
    try {
      await _firebaseStorage.ref('$path/$timeStamp\_$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }

    String dowloadUrl = await _firebaseStorage
        .ref('$path/$timeStamp\_$fileName')
        .getDownloadURL();

    return dowloadUrl;

    /*Reference reference =
        _firebaseStorage.ref().child('$path/$miliSecs\_$fileName');
    String uploadPath = reference.toString();
    print('uploading to $uploadPath');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot result = await uploadTask;
    String url = await result.ref.getDownloadURL();
    print(url);

    return url;*/
  }*/
}
