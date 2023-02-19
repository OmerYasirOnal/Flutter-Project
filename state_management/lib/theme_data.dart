import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = ThemeData(
  buttonColor: Colors.blue.shade700,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.blue.shade50,
);
ThemeData light = ThemeData(
  buttonColor: Color.fromARGB(255, 128, 176, 225),
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.blue.shade50,
);

class ThemeColorData with ChangeNotifier {
  late SharedPreferences _sharedPreferences;
  bool _isGreen = false;

  bool get isGreen => _isGreen;
  ThemeData get themeColor {
    return _isGreen ? dark : light;
  }

  void toggletheme() {
    _isGreen = !_isGreen;
    saveThemeToSharePref(_isGreen);
    notifyListeners();
  }

  Future<void> createSharedPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveThemeToSharePref(bool value) {
    _sharedPreferences.setBool('themeData', value);
  }

  Future<void> loadThemeFromSharedPref() async {
    await createSharedPrefObject();
    if (_sharedPreferences.getBool('themeData') == null) {
      _isGreen = true;
    } else {
      _isGreen = _sharedPreferences.getBool('themeData')!;
    }
  }
}
