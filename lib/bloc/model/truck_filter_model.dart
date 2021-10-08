import 'package:barber_booking/model/truck.dart';
import 'package:equatable/equatable.dart';

class TruckFilter extends Equatable {
  final int id;
  final TruckModel truckModel;
  final bool value;

  TruckFilter(
      {required this.id, required this.truckModel, required this.value});

  TruckFilter copyWith({int? id, TruckModel? truckModel, bool? value}) {
    return TruckFilter(
        id: id ?? this.id,
        truckModel: truckModel ?? this.truckModel,
        value: value ?? this.value);
  }

  @override
  List<Object?> get props => [id, truckModel, value];
}
