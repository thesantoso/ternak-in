import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token methods
  Future<bool> saveToken(String token) async {
    return await _prefs.setString(AppConstants.keyToken, token);
  }

  Future<String?> getToken() async {
    return _prefs.getString(AppConstants.keyToken);
  }

  Future<bool> removeToken() async {
    return await _prefs.remove(AppConstants.keyToken);
  }

  // User methods
  Future<bool> saveUserId(String userId) async {
    return await _prefs.setString(AppConstants.keyUserId, userId);
  }

  Future<String?> getUserId() async {
    return _prefs.getString(AppConstants.keyUserId);
  }

  Future<bool> saveUserName(String userName) async {
    return await _prefs.setString(AppConstants.keyUserName, userName);
  }

  Future<String?> getUserName() async {
    return _prefs.getString(AppConstants.keyUserName);
  }

  // Theme methods
  Future<bool> saveThemeMode(bool isDark) async {
    return await _prefs.setBool(AppConstants.keyThemeMode, isDark);
  }

  bool getThemeMode() {
    return _prefs.getBool(AppConstants.keyThemeMode) ?? false;
  }

  // Generic methods
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> saveDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
