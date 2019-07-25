import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/constants/strings.dart';
import 'package:pazhamuthir_emart/models/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;

  const OrderDetail({this.order});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return ListView(
      children: <Widget>[
        AppTitleWidget(title: "Order ${widget.order.orderNo}"),
        ListView(
          physics: ScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          shrinkWrap: true,
          children: <Widget>[
            _text("Status", GREEN_COLOR, FontWeight.bold, 18),
            Container(padding: EdgeInsets.only(top: 5)),
            _text(
              "${widget.order.status.split('_').join(" ").toLowerCase()}",
              BLACK_COLOR,
              FontWeight.bold,
              18,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
            ),
            _text(
                StringResolver.getTextForOrderStatus(
                    status: widget.order.status),
                BLACK_COLOR,
                null,
                14),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            _text("Support", GREEN_COLOR, FontWeight.bold, 18),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      launch("tel://${widget.order.staff.phoneNumber}");
                    },
                    child: Text(
                      "CALL",
                      style: TextStyle(fontSize: 14, color: GREEN_COLOR),
                    ),
                  ),
                  _text(
                      "Contact the delivery staff to get updates \n or notify changes in your order.",
                      BLACK_COLOR,
                      null,
                      14)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _text("Amount Payable", BLACK_COLOR, FontWeight.bold, 18),
            Container(
              padding: EdgeInsets.only(left: 8, top: 20),
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
                padding: EdgeInsets.only(left: 10, top: 5),
                child: _text(
                    "Please pay Rs. ${widget.order.getTotalPrice()} at time of delivery",
                    BLACK_COLOR,
                    null,
                    14)),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _text("Items in order", BLACK_COLOR, FontWeight.bold, 18),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _listItems(),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _text("Total", BLACK_COLOR, FontWeight.bold, 14),
                _text("Rs. ${widget.order.getTotalPrice()}", BLACK_COLOR,
                    FontWeight.bold, 14),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _text("Delivery Address", BLACK_COLOR, FontWeight.bold, 18),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _address(),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            _text(
                "To notify any changes in your order, address or cancellation. contact support using the option above.",
                BLACK_COLOR,
                null,
                10),
          ],
        ),
      ],
    );
  }

  Widget _text(String text, Color c, FontWeight f, double size) {
    return Text(
      "$text",
      style: TextStyle(color: c, fontWeight: f, fontSize: size),
    );
  }

  Widget _listItems() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.order.cartItems.length,
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _text("${widget.order.cartItems[index].name}", BLACK_COLOR, null, 14),
          _text("Rs. ${widget.order.cartItems[index].price}", BLACK_COLOR,
              FontWeight.bold, 14),
        ],
      ),
    );
  }

  Widget _address() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _text("Deliver to:", BLACK_COLOR, null, 14),
            _text("Mr. ${widget.order.address.name}", BLACK_COLOR,
                FontWeight.bold, 14),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _text("Address:", BLACK_COLOR, null, 14),
            _text("${widget.order.address.addressLine}", BLACK_COLOR,
                FontWeight.bold, 14),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _text("Landmark:", BLACK_COLOR, null, 14),
            _text("${widget.order.address.landmark}", BLACK_COLOR,
                FontWeight.bold, 14),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _text("Contact No:", BLACK_COLOR, null, 14),
            _text("${widget.order.address.phoneNumber}", BLACK_COLOR,
                FontWeight.bold, 14),
          ],
        ),
      ],
    );
  }
}
