import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/screens/your_orders.dart';

class OrderPlaced extends StatefulWidget {
  final String orderNo;
  final int price;

  const OrderPlaced({this.orderNo, this.price});

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.done,
              color: GREEN_COLOR,
              size: 160,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Order Placed",
                style: TextStyle(
                    color: GREEN_COLOR,
                    fontFamily: 'Raleway',
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Order No. ${widget.orderNo}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 57),
                width: 298,
                height: 20,
                child: Divider(
                  color: GREY_COLOR,
                )),
            Container(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                "Please pay",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Rs. ${widget.price}",
                style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: GREEN_COLOR),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "on delivery",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 20, left: 30),
                child: _placeOrder()),
          ],
        ),
      ),
    );
  }

  Widget _placeOrder() {
    return Row(children: <Widget>[
      SizedBox(
          width: 350,
          height: 48,
          child: RaisedButton(
            color: GREEN_COLOR,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => YourOrders()),
                (val) => false,
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Text(
              "OKAY",
              style: TextStyle(
                  color: WHITE_COLOR, fontSize: 18, letterSpacing: 1.8),
            ),
          ))
    ]);
  }
}
