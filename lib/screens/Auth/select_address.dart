import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/components/AppTitleWidget.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';

class SelectAdress extends StatefulWidget {
  @override
  _SelectAdressState createState() => _SelectAdressState();
}

class _SelectAdressState extends State<SelectAdress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return ListView(children: <Widget>[
      Container(
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
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: GREY_COLOR,
                    ),
                  ),
                )
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
            _address(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "ADD NEW ADDRESS",
                  style: TextStyle(color: GREEN_COLOR, fontSize: 14),
                ),
              ),
            ),
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
                    "Rs. 5670",
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
                  Icon(
                    Icons.attach_money,
                    color: GREEN_COLOR,
                  ),
                  Text(
                    "Cash on Delivery",
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
                padding: EdgeInsets.only(left: 10, top: 2),
                child: Text(
                  "Please pay Rs. 5670 at time of delivery",
                  style: TextStyle(
                    color: BLACK_COLOR,
                    fontSize: 14,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 20, top: 140,bottom: 10),
                child: _placeOrder()),
          ],
        ),
      )
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
                Radio(
                  onChanged: (String val) {},
                )
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

  Widget _placeOrder() {
    return Row(children: <Widget>[
      SizedBox(
          width: 350,
          height: 48,
          child: RaisedButton(
            color: GREEN_COLOR,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Home_Screen()),
              // );
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
}
