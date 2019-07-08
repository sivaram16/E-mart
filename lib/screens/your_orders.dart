import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';

class YourOrders extends StatefulWidget {
  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _layout());
  }

  Widget _layout() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitleWidget(
            title: "Your Orders",
          ),
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("ACTIVE ORDERS"))
        ],
      ),
    );
  }
}
