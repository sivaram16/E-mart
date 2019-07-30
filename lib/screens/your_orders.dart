import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/constants/graphql/getCustomerOders.dart';
import 'package:pazhamuthir_emart/constants/strings.dart';
import 'package:pazhamuthir_emart/models/OrderModel.dart';
import 'package:pazhamuthir_emart/screens/order_detail.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:provider/provider.dart';

import 'home.dart';

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
      padding: EdgeInsets.only(left: 5),
      child: ListView(
        children: <Widget>[
          AppTitleWidget(
            title: "Your Orders",
            onBackPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          _getCustomerOrders(),
        ],
      ),
    );
  }

  Widget _orderList(Map result) {
    List data = result["getCustomerOrders"]["orders"];
    final orders =
        data.map((f) => OrderModel.fromJson(f)).toList().reversed.toList();
    final previousOrders = orders
        .where((f) =>
            f.status != OrderStatuses.PLACED_BY_CUSTOMER &&
            f.status != OrderStatuses.RECEIVED_BY_STORE &&
            f.status != OrderStatuses.PICKED_UP)
        .toList();
    final activeOrders = orders
        .where((f) =>
            f.status == OrderStatuses.PLACED_BY_CUSTOMER ||
            f.status == OrderStatuses.RECEIVED_BY_STORE ||
            f.status == OrderStatuses.PICKED_UP)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (activeOrders.length != 0)
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("ACTIVE ORDERS")),
        _activeorder(activeOrders),
        if (previousOrders.length != 0)
          Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("PREVIOUS ORDERS")),
        _previousOrder(previousOrders),
      ],
    );
  }

  Widget _activeorder(List<OrderModel> orders) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10),
        height: 150,
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
                  _text(
                      "#${orders[index].orderNo} (${orders[index].cartItems.length} items)",
                      BLACK_COLOR,
                      FontWeight.bold,
                      14),
                  _text("Rs. ${orders[index].getTotalPrice()}", BLACK_COLOR,
                      FontWeight.bold, 14),
                ],
              ),
              _text("Placed on ${orders[index].updatedDate.toString().substring(0,19)}", BLACK_COLOR, null,
                  14),
              Row(
                children: <Widget>[
                  _text(
                      "${orders[index].status.split('_').join(" ").toLowerCase()}",
                      GREEN_COLOR,
                      FontWeight.bold,
                      18),
                ],
              ),
              _text("Your order is out for delivery and will reach you soon",
                  GREEN_COLOR, null, 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetail(order: orders[index]),
                        ),
                      );
                    },
                    child:
                        _text("VIEW DETAILS", GREY_COLOR, FontWeight.bold, 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _previousOrder(List<OrderModel> orders) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(10),
          height: 150,
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
                    _text(
                        "#${orders[index].orderNo} (${orders[index].cartItems.length} items)",
                        BLACK_COLOR,
                        FontWeight.bold,
                        14),
                    _text("Rs. ${orders[index].getTotalPrice()}", BLACK_COLOR,
                        FontWeight.bold, 14),
                  ],
                ),
                _text("Placed on ${orders[index].updatedDate}", BLACK_COLOR,
                    null, 14),
                Row(
                  children: <Widget>[
                    orders[index].status == OrderStatuses.DELIVERED_AND_PAID
                        ? Icon(
                            Icons.done,
                            size: 24,
                          )
                        : Icon(
                            Icons.cancel,
                            size: 24,
                            color: Colors.red,
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                    ),
                    _text(
                        "${orders[index].status.split("_").join(" ").toLowerCase()}",
                        GREY_COLOR,
                        null,
                        18),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetail(
                                        order: orders[index],
                                      )));
                        },
                        child: InkWell(
                            child: _text("VIEW DETAILS", GREY_COLOR,
                                FontWeight.bold, 14))),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _text(String text, Color c, FontWeight f, double size) {
    return Text(
      "$text",
      style: TextStyle(color: c, fontWeight: f, fontSize: size),
    );
  }

  Widget _getCustomerOrders() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getCustomerOrders,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 3,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getCustomerOrders'] != null) {
          return _orderList(result.data);
        }
        return Container();
      },
    );
  }
}
