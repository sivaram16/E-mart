import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';

class CreateAcc extends StatefulWidget {
  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
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
              _inputField("Name"),
              _inputField("Mobile number"),
              _inputField("Password"),
              _inputField("Confirm Password"),
              Container(
                  padding: EdgeInsets.only(top: 50, left: 100),
                  child: _createAcc()),
            ],
          ))
    ]);
  }

  Widget _inputField(String label) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 53),
      child: TextField(
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

  Widget _createAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 39,
          width: 202,
          child: FlatButton(
            color: GREEN_COLOR,
            onPressed: () {},
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
}
