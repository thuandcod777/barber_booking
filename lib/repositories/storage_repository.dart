import 'dart:io';

import 'package:barber_booking/provider/base_provider.dart';
import 'package:barber_booking/provider/storage_provider.dart';

class StorageRepository {
  BaseStorageProvider storageProvider = StorageProvider();

  Future<String> uploadImage(File file, String path) =>
      storageProvider.uploadImage(file, path);
}
