import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitleWidget(
            title: "Edit Address",
            subtitle:
                "The details like name and phone number provided in the address will be used in delivery of your order at this address. Please ensure they are correct.",
          ),
          _inputField("Name"),
          _inputField("Mobile Number"),
          _inputField("Address"),
          _inputField("Landmark"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 66, left: 10),
                  child: _remove()),
              Container(
                  padding: EdgeInsets.only(top: 66, right: 20), child: _save()),
            ],
          ),
        ],
      ),
    );
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

  Widget _remove() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
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
                "REMOVE",
                style: TextStyle(
                    color: Colors.red, fontSize: 14, letterSpacing: 1.8),
              ),
            ),
          ))
    ]);
  }

  Widget _save() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 202,
              height: 48,
              child: FlatButton(
                color: GREEN_COLOR,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "SAVE CHANGES",
                  style: TextStyle(
                      color: WHITE_COLOR, fontSize: 14, letterSpacing: 1.8),
                ),
              ))
        ]);
  }
}
