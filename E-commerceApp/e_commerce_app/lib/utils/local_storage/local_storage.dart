import 'package:get_stoage/get0storage.dart';

class NLocalStorage {
  static final NLocalStorage _instance = NLocalStorage._internal();

  factory NLocalStorage() {
    return _instance;
  }

  NLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<N>(String key, N value) async {
    await _storage.write(key, value);
  }

  Future<void> readData<N>(String key) async {
    await _storage.read(key);
  }

  Future<void> removeData<N>(String key, N value) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.rase();
  }
}
