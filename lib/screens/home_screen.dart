import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pazhamuthir_emart/screens/Cart.dart';
import 'package:pazhamuthir_emart/screens/my_profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int quantity = 0, rate = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: GREEN_COLOR,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Pazhamuthir',
                        style: TextStyle(color: WHITE_COLOR, fontSize: 36),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 185),
                      child: Text(
                        'E-MART',
                        style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile()),
                          );
                        },
                        child: Text(
                          "Hi, Vineesh",
                          style: TextStyle(
                              color: WHITE_COLOR,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: GREEN_COLOR,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'CATEGORIES',
                      style: TextStyle(color: DARK_GREEN, fontSize: 14),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'ALL',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'VEGETABLES',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'FRUITS',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'DRY FRUITS',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'STATIONERY',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'SNACKS',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'READY TO EAT',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'NAVIGATION',
                      style: TextStyle(color: DARK_GREEN, fontSize: 14),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'SHOP',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'CART',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'ORDERS',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'ACCOUNT',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    'LOGOUT',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: _layout(),
    );
  }

  Widget _layout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _search(),
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: _catText("Vegetables")),
        _items(),
        quantity == 0 ? Container() : _bottomSheet(),
      ],
    );
  }

  Widget _items() {
    return Expanded(
        child: ListView.builder(
            itemCount: 10, itemBuilder: (context, index) => _showItem()));
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16),
          ),
          Builder(
              builder: (context) => InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset('assets/images/menu.svg'))),
          Container(
            padding: EdgeInsets.only(left: 10),
          ),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  size: 30,
                )),
          )),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .15),
            blurRadius: 8,
          )
        ],
        color: WHITE_COLOR,
      ),
    );
  }

  Widget _catText(String s) {
    return Text(
      s,
      style: TextStyle(color: GREY_COLOR, fontSize: 18, fontFamily: 'Raleway'),
    );
  }

  Widget _showItem() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/carrot.png",
            height: 100,
            width: 80,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Carrot",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    "Rs. $rate/kg",
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: quantity == 0 ? _addFlatButton() : _addOutLineButton()),
        ],
      ),
    );
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

  Widget _addOutLineButton() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 120,
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

  Widget _bottomSheet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: GREEN_COLOR,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: MediaQuery.of(context).size.height / 7,
      child: Row(
        children: <Widget>[
          InkWell(onTap: () {}, child: _cartItems()),
          Container(margin: EdgeInsets.only(top: 20, left: 50)),
          _checkout()
        ],
      ),
    );
  }

  Widget _checkout() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 150,
              height: 48,
              child: RaisedButton(
                color: WHITE_COLOR,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
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
                      "CHECK OUT",
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

  Widget _cartItems() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5),
            width: 162,
            height: 67,
            decoration: BoxDecoration(
                border: Border.all(color: WHITE_COLOR),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Text(
                  "2 items in cart",
                  style: TextStyle(
                      fontSize: 14,
                      color: WHITE_COLOR,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs. ${rate * quantity}",
                  style: TextStyle(
                      fontSize: 24,
                      color: WHITE_COLOR,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ]);
  }
}
