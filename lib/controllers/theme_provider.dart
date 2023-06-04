import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/color_model.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  List<String> cityBookMark = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Connectivity _connectivity = Connectivity();
  static bool internet = false;
  static int selPageIndex = 0;

  ThemeProvider() {
    _getDarkThemeProfile();
  }

  Future<void> _getDarkThemeProfile() async {
    final SharedPreferences prefs = await _prefs;
    isDark = prefs.getBool('isDark') ?? false;
    if (isDark) {
      ColorModel.primaryColor = Colors.black87;
      ColorModel.bookMarkBkg = "assets/images/bookmarkbkg2.png";
      ColorModel.cityBkg = "assets/images/citybkg2.jpg";
      ColorModel.splashBkg = "assets/images/splashbkg2.png";
    } else {
      ColorModel.primaryColor = const Color.fromRGBO(90, 65, 123, 1);
      ColorModel.bookMarkBkg = "assets/images/bookmarkbkg.png";
      ColorModel.cityBkg = "assets/images/citybkg.jpg";
      ColorModel.splashBkg = "assets/images/splashbkg1.png";
    }
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    isDark = value;
    if (isDark) {
      ColorModel.primaryColor = Colors.black87;
      ColorModel.bookMarkBkg = "assets/images/bookmarkbkg2.png";
      ColorModel.cityBkg = "assets/images/citybkg2.jpg";
      ColorModel.splashBkg = "assets/images/splashbkg2.png";
    } else {
      ColorModel.primaryColor = const Color.fromRGBO(90, 65, 123, 1);
      ColorModel.bookMarkBkg = "assets/images/bookmarkbkg.png";
      ColorModel.cityBkg = "assets/images/citybkg.jpg";
      ColorModel.splashBkg = "assets/images/splashbkg1.png";
    }
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      internet = true;
    } else {
      internet = false;
    }
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
