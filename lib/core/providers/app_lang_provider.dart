import 'package:flutter/material.dart';

class AppLangProvider extends ChangeNotifier {
  String appLang = "en";

  void changeLange(String newLang) {
    if (appLang == newLang) {
      return;
    }
    appLang = newLang;
    notifyListeners();
  }
}
