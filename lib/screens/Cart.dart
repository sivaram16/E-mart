import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/screens/select_address.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalPrice;
  final VoidCallback clearCartItems;

  Cart({this.cartItems, this.totalPrice, this.clearCartItems});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 0, rate = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 12, top: 48, right: 18),
                child: Text(
                  "Cart",
                  style: TextStyle(
                    color: BLACK_COLOR,
                    fontSize: 32,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 18, top: 55, right: 18),
                child: IconButton(
                  onPressed: () {
                    widget.clearCartItems();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: GREY_COLOR,
                  ),
                ),
              )
            ],
          ),
          _listItems(),
          _bottomSheet(),
        ],
      ),
    );
  }

  Widget _item(Map item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "${item["item"]?.name}",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text("x ${item["quantity"]}"),
        Text(
          "Rs. ${item["price"]}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _bottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: GREEN_COLOR,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("TOTAL",
                  style: TextStyle(
                    color: WHITE_COLOR,
                    fontSize: 14,
                  )),
              Text(
                "Rs. ${widget.totalPrice}",
                style: TextStyle(color: WHITE_COLOR, fontSize: 18),
              )
            ],
          ),
          Text(
            " ${widget.cartItems.length} items",
            style: TextStyle(color: WHITE_COLOR, fontSize: 14),
          ),
          Container(padding: EdgeInsets.only(top: 10), child: _selectAddress()),
        ],
      ),
    );
  }

  Widget _listItems() {
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  height: 20,
                ),
            padding: EdgeInsets.only(left: 10, right: 10),
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) => _item(widget.cartItems[index])));
  }

  Widget _selectAddress() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 223,
              height: 48,
              child: RaisedButton(
                color: WHITE_COLOR,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectAddress(
                              totalPrice: widget.totalPrice,
                            )),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "SELECT ADDRESS",
                      style: TextStyle(
                          color: GREEN_COLOR, fontSize: 14, letterSpacing: 1.8),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: GREEN_COLOR,
                    )
                  ],
                ),
              ))
        ]);
  }
}
