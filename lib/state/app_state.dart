import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _jwtToken = "";
  AppState() {
    getToken();
  }

  Future getToken() async {
    final pref = await SharedPreferences.getInstance();
    final tokenP = pref.getString('token') ?? "";
    if (tokenP != "") _jwtToken = tokenP;
  }

  void setToken(String val) {
    _jwtToken = val;
    notifyListeners();
  }

  String get jwtToken => _jwtToken;
}
