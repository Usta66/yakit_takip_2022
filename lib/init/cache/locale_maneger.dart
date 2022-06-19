import 'package:shared_preferences/shared_preferences.dart';

import 'enum_preferences_keys.dart';


class LocaleManeger {
  static LocaleManeger _intance = LocaleManeger._init();
  SharedPreferences? _preferences;

  static LocaleManeger get instance => _intance;

  LocaleManeger._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static Future<void> prefrencesInit() async {
    // ignore: prefer_conditional_assignment
    if (instance._preferences == null) {
      instance._preferences = await SharedPreferences.getInstance();
    }
    return;
  }

  void setStringValue(EnumPreferencesKeys key, String value) {
    _preferences?.setString(key.toString(), value);
  }

  String? getStringValue(EnumPreferencesKeys key) {
    return _preferences?.getString(key.toString());
  }

  setBoolValue(EnumPreferencesKeys key, bool value) {
    _preferences?.setBool(key.toString(), value);
  }

  bool? getBoolValue(EnumPreferencesKeys key) {
    return _preferences?.getBool(key.toString());
  }

  clear() {
    _preferences?.clear();
  }
}
