import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/constants/graphql/getCustomerInfo.dart';
import 'package:pazhamuthir_emart/screens/add_address.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/login.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    final appState = Provider.of<AppState>(context);

    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitleWidget(
            title: "Your Account",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: Text("LOGGED IN AS ")),
              Container(padding: EdgeInsets.only(right: 20), child: _logout()),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "${appState.name}, ${appState.phoneNumber}",
              style: TextStyle(
                color: GREEN_COLOR,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 52, left: 10),
                  child: Text("SAVED ADDRESSES")),
            ],
          ),
          _getAddressQuery(),
          Expanded(child: Container()),
          Container(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: _aboutText()),
        ],
      ),
    );
  }

  Widget _logout() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 120,
              height: 48,
              child: OutlineButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (val) => false);
                },
                padding: EdgeInsets.all(0),
                color: GREEN_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                        color: Colors.red, fontSize: 14, letterSpacing: 1.8),
                  ),
                ),
              ))
        ]);
  }

  Widget _addAddress() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 50),
          width: 73,
          height: 35,
          child: OutlineButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAddress()),
              );
            },
            padding: EdgeInsets.all(0),
            color: GREEN_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                "ADD",
                style: TextStyle(
                    color: GREEN_COLOR, fontSize: 14, letterSpacing: 1.8),
              ),
            ),
          )),
    );
  }

  Widget _address(Map address) {
    return Container(
      height: 125,
      width: 366,
      margin: EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Mr. ${address["name"]}",
                  style: TextStyle(
                    color: BLACK_COLOR,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddress()));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: GREY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${address["addressLine"]}",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "${address["phoneNumber"]}",
              style: TextStyle(
                fontSize: 12,
                color: BLACK_COLOR,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _aboutText() {
    return Text(
      "Thank you for using Pazhamuthir E-Mart App. \n Developed by Team 404Found",
      style: TextStyle(
        color: GREEN_COLOR,
        fontSize: 14,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getAddressQuery() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getCustomerInfo,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 5,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        String addressString =
            result.data["getCustomerInfo"]["user"]["address"];
        if (addressString == null) {
          return _addAddress();
        }
        Map address = jsonDecode(addressString);
        return _address(address);
      },
    );
  }
}
