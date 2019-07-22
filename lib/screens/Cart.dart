import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:pazhamuthir_emart/screens/select_address.dart';

class Cart extends StatefulWidget {
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
                padding: EdgeInsets.only(left: 18, top: 48, right: 18),
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
                padding: EdgeInsets.only(left: 18, top: 48, right: 18),
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
          _listItems(),
          _bottomSheet(),
        ],
      ),
    );
  }

  Widget _item() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Carrot",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        quantity == 0 ? _addFlatButton() : _addOutLineButton(),
        Text(
          "Rs. ${quantity * rate}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _addOutLineButton() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              height: 48,
              child: OutlineButton(
                padding: EdgeInsets.all(0),
                color: GREEN_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            quantity -= 1;
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          color: BLACK_COLOR,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                            color: BLACK_COLOR,
                            fontSize: 18,
                            letterSpacing: 1.8),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: BLACK_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]);
  }

  Widget _addFlatButton() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 120,
              height: 48,
              child: FlatButton(
                color: GREEN_COLOR,
                onPressed: () {
                  setState(() {
                    quantity += 1;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(
                      color: WHITE_COLOR, fontSize: 18, letterSpacing: 1.8),
                ),
              ))
        ]);
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
                "Rs. 5670",
                style: TextStyle(color: WHITE_COLOR, fontSize: 18),
              )
            ],
          ),
          Text(
            "13 items",
            style: TextStyle(color: WHITE_COLOR, fontSize: 14),
          ),
          Container(padding: EdgeInsets.only(top: 10), child: _checkout()),
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
            itemCount: 5,
            itemBuilder: (context, index) => _item()));
  }

  Widget _checkout() {
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
                    MaterialPageRoute(builder: (context) => SelectAddress()),
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
