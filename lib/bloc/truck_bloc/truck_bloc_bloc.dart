import 'dart:async';
import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/repositories/truck_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'truck_bloc_event.dart';
part 'truck_bloc_state.dart';

class TruckBloc extends Bloc<TruckBlocEvent, TruckBlocState> {
  final TruckDataRepository _truckDataRepository;
  StreamSubscription? _streamSubscription;
  final String? name;

  TruckBloc({required TruckDataRepository truckDataRepository, this.name})
      : _truckDataRepository = truckDataRepository,
        super(TruckLoadingState());

  @override
  Stream<TruckBlocState> mapEventToState(
    TruckBlocEvent event,
  ) async* {
    print(event);
    if (event is LoadTruckEvent) {
      yield* _mapTruckToState();
    } else if (event is RecievedTruckEvent) {
      yield* _mapRecievedToState(event);
    } else if (event is ChangedTruckEvent) {
      yield ChangedTruckState(selectedTrucks: event.selectedTrucks);
    }

    /*if (event is ChangedTruckEvent) {
      yield* _mapChangedToState(event, state);
    }*/
  }

  Stream<TruckBlocState> _mapTruckToState() async* {
    try {
      _streamSubscription?.cancel();

      _streamSubscription =
          _truckDataRepository.getListTrucks().listen((List<TruckModel> truck) {
        add(RecievedTruckEvent(trucks: truck));
      });
    } on Exception {
      yield TruckFailedState();
    }
  }

  Stream<TruckBlocState> _mapRecievedToState(RecievedTruckEvent event) async* {
    yield TruckLoadedState(trucks: event.trucks);
  }

  /* Stream<TruckBlocState> _mapChangedToState(
      ChangedTruckEvent event, TruckBlocState state) async* {
    if (state is TruckLoadedState) {
      final List<TruckModel> selected = state.trucks.map((selectedTruck) {
        return selectedTruck.id == event.selectedTrucks.id
            ? event.selectedTrucks
            : selectedTruck;
      }).toList();

      yield TruckLoadedState(trucks: selected);
    }
  }*/

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    super.close();
  }
}
