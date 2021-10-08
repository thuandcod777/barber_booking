import 'dart:async';

import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/repositories/truck_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'truck_state.dart';

class TruckCubit extends Cubit<TruckState> {
  final TruckDataRepository _truckDataRepository;
  StreamSubscription? _trucDataSubscription;

  TruckCubit({required TruckDataRepository truckDataRepository})
      : _truckDataRepository = truckDataRepository,
        super(TruckInit()) {
    getDataTruck();
  }

  Stream<TruckState> getDataTruck() async* {
    try {
      emit(TruckDataLoading());
      await _trucDataSubscription?.cancel();
      _trucDataSubscription = _truckDataRepository
          .getListTrucks()
          .listen((List<TruckModel> truck) => emit(TruckDataLoaded(truck)));

      // print(_trucDataSubscription);
    } on Exception {
      emit(ErrorState('error'));
    }
  }

  /* Future<void> getDataTruck() async {
    try {
      emit(TruckDataLoading());
      final truck = await _truckDataRepository.getListTrucks();

      emit(TruckDataLoaded(truck));
    } on Exception {
      emit(ErrorState('error'));
    }
  }*/

  @override
  Future<void> close() async {
    await _trucDataSubscription?.cancel();
    super.close();
  }
}
