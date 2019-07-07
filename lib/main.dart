import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/screens/Auth/auth_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}
