import 'package:barber_booking/model/booking.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormOrderState> {
  FormBloc() : super(FormOrderState());

  Stream<FormOrderState> mapEventToState(FormEvent event) async* {
    print(event);

    if (event is ChangeNameEvent) {
      yield* _mapChangeName(event.name);
    }
    if (event is ChangeDateEvent) {
      yield* _mapChangeDate(event.date);
    }
    if (event is ChangeNameProductEvent) {
      yield* _mapNameProductDate(event.nameProduct);
    }
    if (event is ChangeNumberProductEvent) {
      yield* _mapNumberProductDate(event.numberProduct);
    }
    /*  if (event is ChangeDropDownMassEvent) {
      yield* _mapDropDownMassProductDate(event.dropDownMass);
    } */

    if (event is ChangeDropDownEvent) {
      yield* _mapDropDown(event);
    }

    if (event is ListDynamicEvent) {
      yield* _mapListDynamic(event.index, event.value);
    }
  }

  Stream<FormOrderState> _mapChangeName(String? name) async* {
    yield state.copyWith(name: name);
  }

  Stream<FormOrderState> _mapChangeDate(DateTime? date) async* {
    yield state.copyWith(date: date);
  }

  Stream<FormOrderState> _mapNameProductDate(String? nameProduct) async* {
    yield state.copyWith(nameProduct: nameProduct);
  }

  Stream<FormOrderState> _mapNumberProductDate(String? numberProduct) async* {
    yield state.copyWith(numberProduct: numberProduct);
  }

  Stream<FormOrderState> _mapDropDown(ChangeDropDownEvent event) async* {
    List<DynamicModel> data = event.model.getItemMass();
    yield LoadDataMass(listDropdown: data);
    print(data);
  }

  Stream<FormOrderState> _mapListDynamic(int index, String value) async* {
    int foundKey = -1;
    List<Map<String, dynamic>> _values = [];
    for (var map in _values) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }

    /*   Map<String, dynamic> json = {
      "id": event.index,
      "value": {
        "textNamePr": event.value!.nameProduct,
        "textNumberPr": event.value!.numberProduct,
      },
    }; */

    /*  Map<String, dynamic> json = {"id": index, "value": value};

    _values.add(json); */

    yield ListDynamic(dynamicList: _values);
  }
}
