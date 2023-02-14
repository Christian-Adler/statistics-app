import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceStorage {
  static const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Read value
  static Future<String?> read(String key) async {
    return storage.read(key: key);
  }

  // Read all values
  static Future<Map<String, String>> readAll() async {
    return storage.readAll();
  }

  // Delete value
  static Future<void> delete(String key) async {
    storage.delete(key: key);
  }

  // Delete all
  static Future<void> deleteAll() async {
    storage.deleteAll();
  }

  // Write value
  static Future<void> write(String key, String? value) async {
    storage.write(key: key, value: value);
  }
}
