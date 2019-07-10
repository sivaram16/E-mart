import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/constants/graphql/customerRegisterAuth.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';

class CreateAcc extends StatefulWidget {
  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  Map input = {
    "name": "",
    "phoneNumber": "",
    "password": "",
    "confirmPassword": ""
  };
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
              _inputField("Name", "name"),
              _inputField("Mobile Number", "phoneNumber"),
              _inputField("Password", "password", secure: true),
              _inputField("Confirm Password", "confirmPassword", secure: true),
              Container(
                  padding: EdgeInsets.only(top: 50, left: 100),
                  child: _mutationComponent()),
            ],
          ))
    ]);
  }

  Widget _inputField(String label, String key, {bool secure = false}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 53),
      child: TextField(
        obscureText: secure,
        onChanged: (value) {
          setState(() {
            input[key] = value;
          });
        },
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

        if (resultData != null &&
            resultData['customerRegister']['error'] == null) {
          final user =
              UserModel.fromJson(resultData['customerRegister']['user']);
          if (user != null) {
            await prefs.setString(
                'token', resultData['customerRegister']['jwtToken']);

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
