import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pazhamuthir_emart/constants/graphql/createNewOrder.dart';
import 'package:pazhamuthir_emart/constants/graphql/getCustomerInfo.dart';
import 'package:pazhamuthir_emart/screens/add_address.dart';
import 'package:pazhamuthir_emart/screens/order_placed.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:pazhamuthir_emart/state/cart_state.dart';
import 'package:provider/provider.dart';

class SelectAddress extends StatefulWidget {
  final double totalPrice;

  const SelectAddress({this.totalPrice});

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getAddressQuery(),
    );
  }

  Widget _layout(QueryResult address) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppTitleWidget(
                title: "Select Address",
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Deliver to",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _address(address),
          Container(
            padding: EdgeInsets.only(top: 45, left: 8, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Amount Payable",
                  style: TextStyle(
                    color: BLACK_COLOR,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Rs. ${widget.totalPrice}",
                  style: TextStyle(
                    color: GREEN_COLOR,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8, top: 32),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/Vector.svg',
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      color: GREEN_COLOR,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 2),
            child: Text(
              "Please pay Rs. ${widget.totalPrice} at time of delivery",
              style: TextStyle(
                color: BLACK_COLOR,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: _mutationComponent(address)),
        ],
      ),
    );
  }

  Widget _address(QueryResult result) {
    if (result.loading) {
      return Center(child: CupertinoActivityIndicator());
    }
    String addressString = result.data["getCustomerInfo"]["user"]["address"];
    Map address = jsonDecode(addressString);

    if (addressString == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.all(10),
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
                Radio(
                  onChanged: (String val) {},
                  groupValue: null,
                  value: null,
                )
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

  Widget _placeOrder(RunMutation runmutation, Map address) {
    final cartState = Provider.of<CartState>(context);

    return Row(children: <Widget>[
      SizedBox(
          width: 350,
          height: 48,
          child: RaisedButton(
            color: GREEN_COLOR,
            onPressed: () {
              final cartList = cartState.cartItems.map((f) {
                f.remove("item");
                return f;
              }).toList();
              runmutation({
                "address": address,
                "cartItems": cartList,
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Text(
              "PLACE ORDER",
              style: TextStyle(
                  color: WHITE_COLOR, fontSize: 18, letterSpacing: 1.8),
            ),
          ))
    ]);
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
        return _layout(result);
      },
    );
  }

  Widget _mutationComponent(QueryResult result) {
    final appState = Provider.of<AppState>(context);
    if (result.loading) {
      return Center(child: CupertinoActivityIndicator());
    }
    String addressString = result.data["getCustomerInfo"]["user"]["address"];
    Map address = jsonDecode(addressString);

    if (addressString == null) {
      return Container();
    }

    return Mutation(
      options: MutationOptions(
        document: createNewOrder,
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
        return _placeOrder(runMutation, address);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final Map order = resultData["createNewOrder"]["orders"][0];

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => OrderPlaced(
                    orderNo: order["orderNo"],
                    price: order["totalPrice"],
                  )),
          (val) => false,
        );
      },
    );
  }
}
