import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/constants/graphql/customerLoginAuth.dart';
import 'package:pazhamuthir_emart/models/UserModel.dart';
import 'package:pazhamuthir_emart/screens/home_screen.dart';
import 'package:pazhamuthir_emart/screens/Auth/createAcc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Map input = {"number": "", "password": ""};

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
          _numberTextField(),
          Container(margin: EdgeInsets.only(top: 10)),
          _userpasswordField(),
          Container(margin: EdgeInsets.only(top: 20)),
          _mutationComponent(),
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
          fontFamily: 'Raleway',
          fontSize: 24,
          color: WHITE_COLOR,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _numberTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          input["number"] = value;
        });
      },
      style: TextStyle(color: WHITE_COLOR),
      decoration: InputDecoration(
        labelText: "Phone Number",
        helperStyle: TextStyle(color: WHITE_COLOR),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: WHITE_COLOR)),
        labelStyle: TextStyle(
          color: WHITE_COLOR,
          fontFamily: 'Raleway',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _userpasswordField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          input["password"] = value;
        });
      },
      style: TextStyle(color: WHITE_COLOR),
      obscureText: true,
      decoration: InputDecoration(
        helperStyle: TextStyle(color: WHITE_COLOR),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: WHITE_COLOR)),
        labelText: "Password",
        labelStyle: TextStyle(
          color: WHITE_COLOR,
          fontFamily: 'Raleway',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _loginButton(RunMutation runmutation) {
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
                  runmutation({
                    "phoneNumber": input['number'],
                    "password": input['password'],
                  });
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

  Widget _createAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 38,
          width: 223,
          child: OutlineButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAcc()),
              );
            },
            child: Text(
              "CREATE ACCOUNT",
              style: TextStyle(color: WHITE_COLOR, fontSize: 14),
            ),
            borderSide: BorderSide(color: WHITE_COLOR),
            highlightedBorderColor: WHITE_COLOR,
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
        document: customerLogin,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return _loginButton(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final prefs = await SharedPreferences.getInstance();

        if (resultData != null &&
            resultData['customerLogin']['error'] == null) {
          final user = UserModel.fromJson(resultData['customerLogin']['user']);
          if (user != null) {
            await prefs.setString(
                'token', resultData['customerLogin']['jwtToken']);

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
