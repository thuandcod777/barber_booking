part of 'truck_bloc_bloc.dart';

abstract class TruckBlocEvent extends Equatable {
  const TruckBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadTruckEvent extends TruckBlocEvent {}

class RecievedTruckEvent extends TruckBlocEvent {
  final List<TruckModel> trucks;

  RecievedTruckEvent({required this.trucks});

  @override
  List<Object> get props => [trucks];
}

class ChangedTruckEvent extends TruckBlocEvent {
  final TruckModel selectedTrucks;

  ChangedTruckEvent({required this.selectedTrucks});

  @override
  List<Object> get props => [selectedTrucks];
}
