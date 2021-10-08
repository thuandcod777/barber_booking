part of 'truck_cubit.dart';

abstract class TruckState extends Equatable {
  @override
  List<Object> get props => [];
}

class TruckInit extends TruckState {}

class TruckDataLoading extends TruckState {}

class TruckDataLoaded extends TruckState {
  final List<TruckModel> trucks;

  TruckDataLoaded(this.trucks);

  @override
  List<Object> get props => [trucks];
}

class ErrorState extends TruckState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
