part of 'truck_bloc_bloc.dart';

abstract class TruckBlocState extends Equatable {
  const TruckBlocState();

  @override
  List<Object> get props => [];
}

//class TruckBlocInitial extends TruckBlocState {}

class TruckLoadingState extends TruckBlocState {
  @override
  List<Object> get props => [];
}

class TruckLoadedState extends TruckBlocState {
  final List<TruckModel> trucks;

  TruckLoadedState({required this.trucks});

  @override
  List<Object> get props => [trucks];
}

class TruckFailedState extends TruckBlocState {
  @override
  List<Object> get props => [];
}

class ChangedTruckState extends TruckBlocState {
  final TruckModel selectedTrucks;

  ChangedTruckState({required this.selectedTrucks});

  @override
  List<Object> get props => [selectedTrucks];
}
