import 'package:flutter/material.dart';
// Step1
class LocaleProvider with ChangeNotifier {
  String _languageCode = 'en';  

  String get languageCode => _languageCode;          
  Locale get locale => Locale(_languageCode);        

  void changeLanguage(String langCode) {
    if (langCode == 'ar') {
      _languageCode = 'ar';
    } else {
      _languageCode = 'en';
    }

    notifyListeners(); 
  }
}
