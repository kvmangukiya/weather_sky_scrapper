import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/functions.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  List<String> cityBookMark = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static int selPageIndex = 0;

  ThemeProvider() {
    _getDarkThemeProfile();
  }

  Future<void> _getDarkThemeProfile() async {
    final SharedPreferences prefs = await _prefs;
    isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    isDark = value;
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  addBookMark({required String city}) async {
    if (!cityBookMark.contains(city)) {
      cityBookMark.add(city);
      await _setStringList("cityBookMark", cityBookMark);
    }
    notifyListeners();
  }

  removeBookMark({required String city}) async {
    if (cityBookMark.contains(city)) {
      cityBookMark.remove(city);
      await _setStringList("cityBookMark", cityBookMark);
    }
    notifyListeners();
  }

  Future<void> getBookMark() async {
    cityBookMark = await _getStringList("cityBookMark");
    notifyListeners();
  }

  // retrieval of String List
  Future<List<String>> _getStringList(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(key) ?? [];
  }

  // saving the String List
  Future<void> _setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(key, value);
  }
}
