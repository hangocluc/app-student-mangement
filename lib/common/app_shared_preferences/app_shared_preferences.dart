import 'package:native_shared_preferences/native_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

class AppSharedPreferences {
  final sp.SharedPreferences prefs;
  final NativeSharedPreferences nativePrefs;

  const AppSharedPreferences({required this.prefs, required this.nativePrefs});

  Object? get(String key) => prefs.get(key) ?? nativePrefs.get(key);

  bool? getBool(String key) => prefs.getBool(key) ?? nativePrefs.getBool(key);

  int? getInt(String key) => prefs.getInt(key) ?? nativePrefs.getInt(key);

  double? getDouble(String key) =>
      prefs.getDouble(key) ?? nativePrefs.getDouble(key);

  String? getString(String key) =>
      prefs.getString(key) ?? nativePrefs.getString(key);

  List<String>? getStringList(String key) =>
      prefs.getStringList(key) ?? nativePrefs.getStringList(key);

  bool containsKey(String key) =>
      prefs.containsKey(key) || nativePrefs.containsKey(key);

  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);

  Future<bool> setInt(String key, int value) => prefs.setInt(key, value);

  Future<bool> setDouble(String key, double value) =>
      prefs.setDouble(key, value);

  Future<bool> setString(String key, String value) =>
      prefs.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) =>
      prefs.setStringList(key, value);

  Future<bool> remove(String key) => prefs.remove(key);

  Future<bool> clear() => prefs.clear();
}
