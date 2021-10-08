import 'package:barber_booking/model/users.dart';
import 'package:barber_booking/provider/base_provider.dart';
import 'package:barber_booking/provider/user_data_provider.dart';

class UserDataRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<UsersModel> saveProfileUser(String uid, String photo, String name,
          String email, String address) =>
      userDataProvider.saveProfileUser(photo, name, email, address);

  Future<UsersModel> getUser() => userDataProvider.getUser();

  Future<bool> isFirstTime(String userId) =>
      userDataProvider.isFirstTime(userId);

  // getLocation(String? address) {}
}
