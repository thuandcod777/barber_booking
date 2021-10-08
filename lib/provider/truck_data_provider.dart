import 'dart:async';

import 'package:barber_booking/config/path.dart';
import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TruckDataProvider extends BaseDataTruckProvider {
  final FirebaseFirestore _firebaseStorage;

  TruckDataProvider({FirebaseFirestore? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseFirestore.instance;

  @override
  Stream<List<TruckModel>> getListTrucks() {
    /*return _firebaseStorage
        .collection(Paths.truckPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TruckModel.fromMap(doc)).toList();
    });*/

    CollectionReference<Map<String, dynamic>> truckCollection =
        _firebaseStorage.collection(Paths.truckPath);

    return truckCollection.snapshots().transform(StreamTransformer<
            QuerySnapshot<Map<String, dynamic>>, List<TruckModel>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> querySnapshot,
                EventSink<List<TruckModel>> sink) =>
            mapDocumentToTruck(querySnapshot, sink)));
  }

  void mapDocumentToTruck(
      QuerySnapshot<Map<String, dynamic>> querySnapshot, EventSink sink) async {
    List<TruckModel> trucks = [];

    for (DocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      print(document.data);
      trucks.add(TruckModel.fromMap(document));
    }

    sink.add(trucks);
  }

  /*@override 
  Future<List<TruckModel>> getListTrucks() async {

    CollectionReference<Map<String, dynamic>> truckCollection =
        _firebaseStorage.collection(Paths.truckPath);

    final querySnapshot = await truckCollection.limit(10).get();

    List<TruckModel> dataList = [];

    querySnapshot.docs.forEach((doc) {
      dataList.add(TruckModel.fromMap(doc));
    });

    return dataList;
  }*/

}
