import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/screens/add_address.dart';

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
    return Container(
      padding: EdgeInsets.only(left: 10, right: 0),
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
              "Vineesh, 9944542312",
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
              Container(
                  padding: EdgeInsets.only(left: 170, top: 52),
                  child: _addAddress()),
            ],
          ),
          _address(),
          Container(
              padding: EdgeInsets.only(left: 10, top: 170),
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
                onPressed: () {},
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
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
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
              ))
        ]);
  }

  Widget _address() {
    return Container(
      height: 125,
      width: 366,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(3.0),
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
                  "Mr. Vineesh",
                  style: TextStyle(
                    color: BLACK_COLOR,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 140),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: GREY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "10/672, Madalayam Road,\nJanata Nagar, Coimbatore - 641035",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "+91 9897866767",
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
      "Thank you for using Pazhamuthir E-Mart App. \n Developed by SIVARAM",
      style: TextStyle(
        color: GREEN_COLOR,
        fontSize: 14,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
