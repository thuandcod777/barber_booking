import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? name;
  final String? nameProduct;
  //final List<String>? numberProduct;
  //final DropdownModel? dropdownModel;
  final DynamicModel? dynamicModel;
  DateTime? date;

  BookingModel({
    this.name,
    this.dynamicModel,
    this.nameProduct,
    this.date,
  });

  factory BookingModel.fromMap(DocumentSnapshot<Map<String, dynamic>>? map) {
    return BookingModel(
      name: map?['name'],
      nameProduct: map?['nameProduct'],
      dynamicModel: map?['dynamicModel'],
      date: map?['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dynamicModel': dynamicModel,
      'time': date,
    };
  }
}

class DynamicModel extends BookingModel {
  final int? id;
  final String? nameProduct;
  String? numberProduct;
  String? item;

  DynamicModel({this.id, this.item, this.numberProduct, this.nameProduct});

  factory DynamicModel.fromMap(DocumentSnapshot<Map<String, dynamic>>? map) {
    return DynamicModel(
        nameProduct: map?['nameProduct'],
        numberProduct: map?['numberProduct'],
        item: map?['item']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nameProduct': nameProduct,
      'numberProduct': nameProduct,
      'item': item,
    };
  }

  final mass = [
    DynamicModel(item: 'Kg'),
    DynamicModel(item: 'Tan'),
    DynamicModel(item: 'Thung'),
    DynamicModel(item: 'Kien'),
  ];

  List<DynamicModel> getItemMass() => List.generate(
        mass.length,
        (index) => DynamicModel(item: mass[index].item),
      );
}
