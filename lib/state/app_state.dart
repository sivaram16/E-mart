import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _jwtToken = "";
  String _name = "";
  String _phno = "";
  AppState() {
    getToken();
  }

  Future getToken() async {
    final pref = await SharedPreferences.getInstance();
    final tokenP = pref.getString('token') ?? "";
    final name = pref.getString('name') ?? "";
    final phonenumber = pref.getString('phone number');
    if (tokenP != "") _jwtToken = tokenP;
    if (name != "") _name = name;
    if (phonenumber != "") _phno = phonenumber;
  }

  void setToken(String val) {
    _jwtToken = val;
    notifyListeners();
  }

  void setPhoneNumner(String no) {
    _phno = no;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  String get phoneNumber => _phno;

  String get jwtToken => _jwtToken;

  String get name => _name;
}
