import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/constants/graphql/customerRegisterAuth.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/models/UserModel.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map input = {
    "name": "",
    "phoneNumber": "",
    "password": "",
    "confirmPassword": ""
  };
  String errors = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 10, right: 28),
          child: Column(
            children: <Widget>[
              AppTitleWidget(
                title: "Create Account",
                subtitle:
                    "The details you provide here will be used for managing this app. You can provide multiple addresses and different details for those addresses.",
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              _inputField("Name", "name", TextInputType.text),
              _inputField("Mobile Number", "phoneNumber", TextInputType.number),
              _inputField("Password", "password", TextInputType.text,
                  secure: true),
              _inputField(
                  "Confirm Password", "confirmPassword", TextInputType.text,
                  secure: true),
              Container(
                margin: EdgeInsets.only(top: 30),
              ),
              if (errors != "")
                Center(
                    child: Text(
                  "$errors !!",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
              if (input['name'] != "" &&
                  input['phoneNumber'] != "" &&
                  input['password'] != "" &&
                  input['confirmPassword'] != "" &&
                  input['password'] == input['confirmPassword'])
                Container(
                    padding: EdgeInsets.only(top: 30, left: 100),
                    child: _mutationComponent()),
            ],
          ))
    ]);
  }

  Widget _inputField(String label, String key, TextInputType k,
      {bool secure = false}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 53),
      child: TextField(
        obscureText: secure,
        onChanged: (value) {
          setState(() {
            input[key] = value;
          });
        },
        keyboardType: k,
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: BLACK_COLOR)),
          labelText: "$label",
          labelStyle: TextStyle(
              fontFamily: 'Raleway', color: BLACK_COLOR, fontSize: 18),
        ),
      ),
    );
  }

  Widget _createAcc(RunMutation runMutation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 39,
          width: 202,
          child: FlatButton(
            color: GREEN_COLOR,
            onPressed: () {
              print(input);
              runMutation({
                "name": input['name'],
                "phoneNumber": input['phoneNumber'],
                "password": input['password'],
              });
            },
            child: Text(
              "CREATE ACCOUNT",
              style: TextStyle(color: WHITE_COLOR, fontSize: 14),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mutationComponent() {
    return Mutation(
      options: MutationOptions(
        document: customerRegister,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return _createAcc(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final prefs = await SharedPreferences.getInstance();
        final appState = Provider.of<AppState>(context);

        if (resultData['customerRegister']['error'] != null) {
          setState(() {
            errors = resultData['customerRegister']['error']['message'];
          });
        }

        if (resultData != null &&
            resultData['customerRegister']['error'] == null) {
          final user =
              UserModel.fromJson(resultData['customerRegister']['user']);
          if (user != null) {
            final String token = resultData['customerRegister']['jwtToken'];

            await prefs.setString('token', token);
            await prefs.setString('name', user.name);
            await prefs.setString('phone number', user.phoneNumber);
            appState.setToken(token);
            appState.setName(user.name);
            appState.setPhoneNumner(user.phoneNumber);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        }
      },
    );
  }
}
