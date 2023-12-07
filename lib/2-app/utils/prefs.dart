import 'package:flutter_secure_storage/flutter_secure_storage.dart';

late final FlutterSecureStorage secureStorage;

extension FlutterSecureStorageExtension on FlutterSecureStorage {
  Future<String?> readSecurePrefs(String key) async {
    try {
      return await read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> writeSecurePrefs(String key, String? value) async {
    await write(key: key, value: value);
  }

  Future<bool> exists(String key) async {
    return containsKey(key: key);
  }
}
