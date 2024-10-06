import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage box;
  static const STORAGE_NAME = "rve_lms_storage";
  static const REMEMBER_LOGIN = "remember_login";
  static const USER_INFO = "user_info";

  Future<StorageService> init() async {
    await GetStorage.init(STORAGE_NAME);
    box = GetStorage(STORAGE_NAME);
    return this;
  }

  Future<void> saveConfig(String key, String value) async {
    box.write(key, value);
  }

  Future<String> getConfig(String key) async {
    final token = await box.read(key);
    return token;
  }

  Future<void> removeAll() async {
    await box.erase();
  }
}
