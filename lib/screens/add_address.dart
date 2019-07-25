import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/constants/graphql/customerUpdate.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:provider/provider.dart';


class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  Map input = {"Name": "", "Mobile Number": "", "Address": "", "Landmark": ""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return ListView(
      children: <Widget>[
        Container(
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
                      padding: EdgeInsets.only(top: 66, right: 20),
                      child: _mutationComponent()),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _inputField(String label) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 53),
      child: TextField(
        onChanged: (value) {
          setState(() {
            input["$label"] = value;
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

  Widget _remove() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
      SizedBox(
          width: 120,
          height: 48,
          child: OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.all(0),
            color: GREEN_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                "CANCEL",
                style: TextStyle(
                    color: Colors.red, fontSize: 14, letterSpacing: 1.8),
              ),
            ),
          ))
    ]);
  }

  Widget _save(RunMutation runmutation) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 202,
              height: 48,
              child: FlatButton(
                color: GREEN_COLOR,
                onPressed: () {
                  runmutation({
                    "address": {
                      "name": input['Name'],
                      "phoneNumber": input['Mobile Number'],
                      "addressLine": input["Address"],
                      "landmark": input["Landmark"]
                    }
                  });
                },
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

  Widget _mutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: customerUpdateAddress,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return _save(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        print(resultData);
        Navigator.pop(context);
      },
    );
  }
}
