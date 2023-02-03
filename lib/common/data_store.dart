import 'package:shared_preferences/shared_preferences.dart';

abstract class DataStore {
  DataStore(SharedPreferences sharedPreferences);

  Future<void> setString(String key, String value);

  String? getString(String key);

  Future<void> delete({required String key});
}

class DefaultStore implements DataStore {
  final SharedPreferences _sharedPreferences;

  DefaultStore(this._sharedPreferences);

  @override
  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> delete({required String key}) async =>
      await _sharedPreferences.remove(key);
}
