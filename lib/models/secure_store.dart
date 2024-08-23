import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final _store = FlutterSecureStorage();
  Future writeSecureData(String key, String value) async {
    var writeData = await _store.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await _store.read(key: key);
    return readData ?? "";
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _store.delete(key: key);
    return deleteData;
  }
}
