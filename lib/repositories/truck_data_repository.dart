import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:barber_booking/provider/truck_data_provider.dart';

class TruckDataRepository {
  BaseDataTruckProvider truckdata = TruckDataProvider();

  Stream<List<TruckModel>> getListTrucks() => truckdata.getListTrucks();

  List<TruckModel> trucks = [];
  set setItem(TruckModel? updatedItem) {
    var itemIndex = trucks.indexWhere((item) => item.id == updatedItem!.id);
    trucks[itemIndex] = updatedItem!;
  }
  //Future<List<TruckModel>> getListTrucks() => truckdata.getListTrucks();
}
