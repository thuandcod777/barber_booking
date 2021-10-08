import 'package:barber_booking/model/truck.dart';
import 'package:equatable/equatable.dart';

class Filters extends Equatable {
  final List<TruckModel> truckFilters;

  Filters({required this.truckFilters});

  Filters copyWith({List<TruckModel>? truckFilters}) {
    return Filters(truckFilters: truckFilters ?? this.truckFilters);
  }

  @override
  List<Object?> get props => [truckFilters];
}
