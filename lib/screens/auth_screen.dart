import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/screens/home_screen.dart';

class Auth_Screen extends StatefulWidget {
  @override
  _Auth_ScreenState createState() => _Auth_ScreenState();
}

class _Auth_ScreenState extends State<Auth_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return ListView(
      children: <Widget>[_title(), _bottomSheet()],
    );
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 80),
      child: Column(
        children: <Widget>[
          _text(
            "Pazhamuthir",
            36,
            GREEN_COLOR,
            FontWeight.bold,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
          ),
          _text(
            "E-MART",
            14,
            BLACK_COLOR,
            null,
          )
        ],
      ),
    );
  }

  Widget _text(String text, double si, Color clr, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(
        color: clr,
        fontSize: si,
        fontWeight: weight,
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 7.65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: GREEN_COLOR,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView(
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 5)),
          _loginText(),
          Container(margin: EdgeInsets.only(top: 40)),
          _usernameTextField(),
          Container(margin: EdgeInsets.only(top: 10)),
          _userpasswordField(),
          Container(margin: EdgeInsets.only(top: 20)),
          Row(
            children: <Widget>[
              _forgot(),
              Container(margin: EdgeInsets.only(top: 20)),
              _loginButton()
            ],
          ),
          Container(margin: EdgeInsets.only(top: 70)),
          _createAcc(),
        ],
      ),
    );
  }

  Widget _loginText() {
    return Text(
      "Sign in",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Raleway-Bold',
          fontSize: 24,
          color: WHITE_COLOR,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _usernameTextField() {
    return TextField(
      style: TextStyle(color: WHITE_COLOR),
      decoration: InputDecoration(
        labelText: "Phone Number",
        helperStyle: TextStyle(color: WHITE_COLOR),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: WHITE_COLOR)),
        labelStyle: TextStyle(
          color: WHITE_COLOR,
          fontFamily: 'Raleway-Regular',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _userpasswordField() {
    return TextField(
      style: TextStyle(color: WHITE_COLOR),
      decoration: InputDecoration(
        helperStyle: TextStyle(color: WHITE_COLOR),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: WHITE_COLOR)),
        labelText: "Password",
        labelStyle: TextStyle(
          color: WHITE_COLOR,
          fontFamily: 'Raleway-Regular',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 150,
              height: 48,
              child: RaisedButton(
                color: WHITE_COLOR,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_Screen()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      color: GREEN_COLOR, fontSize: 18, letterSpacing: 1.8),
                ),
              ))
        ]);
  }

  Widget _forgot() {
    return FlatButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Text(
        "FORGOT PASSWORD ?",
        style: TextStyle(fontSize: 14, color: WHITE_COLOR),
      ),
    );
  }

  Widget _createAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 38,
          width: 223,
          child: OutlineButton(
            onPressed: () {},
            child: Text(
              "CREATE ACCOUNT",
              style: TextStyle(color: WHITE_COLOR, fontSize: 14),
            ),
            borderSide: BorderSide(color: WHITE_COLOR),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
