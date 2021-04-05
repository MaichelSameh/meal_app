import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _getThemeMode();
    _getColorsValues();
  }

  var primaryColor;
  var accentColor;

  var tm;

  String themeText = "s";

  void onChanged(newColor, n) {
    n == 1
        ? primaryColor = _setMaterialColor(newColor.hashCode)
        : accentColor = _setMaterialColor(newColor.hashCode);
    notifyListeners();
    _setColorsValues();
  }

  void _setColorsValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("primaryColor", primaryColor.hashCode);
    pref.setInt("accentColor", accentColor.hashCode);
  }

  void _getColorsValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    primaryColor =
        _setMaterialColor(pref.getInt("primaryColor") ?? Colors.pink.hashCode);
    accentColor =
        _setMaterialColor(pref.getInt("accentColor") ?? Colors.pink.hashCode);
    notifyListeners();
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(newThemeVal);
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("themeText", themeText);
  }

  void _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark) {
      themeText = "d";
    } else if (tm == ThemeMode.light) {
      themeText = "l";
    } else if (tm == ThemeMode.system) {
      themeText = "s";
    }
  }

  void _getThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String theme = pref.getString("themeText") ?? "s";

    if (theme == "s") {
      tm = ThemeMode.system;
    } else if (theme == "d") {
      tm = ThemeMode.dark;
    } else if (theme == "l") {
      tm = ThemeMode.light;
    }

    notifyListeners();
  }

  MaterialColor _setMaterialColor(int colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }
}
