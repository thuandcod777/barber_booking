import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TruckModel extends Equatable {
  final String? id;
  final String? nameTruck;
  final String? typeTruck;
  final String? licensePlate;
  bool value;
  // final String? imageTruc;

  TruckModel(
      {this.id,
      this.nameTruck,
      this.typeTruck,
      this.licensePlate,
      this.value = false
      /* this.imageTruc*/
      });

  factory TruckModel.fromMap(DocumentSnapshot<Map<String, dynamic>>? map) {
    return TruckModel(
      id: map?['id'],
      nameTruck: map?['nametruck'],
      typeTruck: map?['typetruck'],
      licensePlate: map?['licenseplate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nametruck': nameTruck,
      'typetruck': typeTruck,
      'licenseplate': licensePlate,
    };
  }

  TruckModel copyWith(
          {String? id,
          String? nameTruck,
          String? typeTruck,
          String? licensePlate,
          bool? value}) =>
      TruckModel(
          id: id ?? this.id,
          nameTruck: nameTruck ?? this.nameTruck,
          typeTruck: typeTruck ?? this.typeTruck,
          licensePlate: licensePlate ?? this.licensePlate,
          value: value ?? this.value);

  @override
  List<Object?> get props => [id, nameTruck, typeTruck, licensePlate, value];
}
