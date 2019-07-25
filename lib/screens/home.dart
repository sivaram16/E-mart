import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pazhamuthir_emart/constants/graphql/getAllInventory.dart';
import 'package:pazhamuthir_emart/models/InventoryItemModel.dart';
import 'package:pazhamuthir_emart/screens/cart.dart';
import 'package:pazhamuthir_emart/screens/my_profile.dart';
import 'package:pazhamuthir_emart/screens/your_orders.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:pazhamuthir_emart/state/cart_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalPrice = 0;
  List<String> categories = ["All"];
  String query = "";
  String selectedCategory = "All";
  String name = "";

  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: _layout(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Drawer(
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
                    padding: EdgeInsets.only(top: 40),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfile()),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.face,
                            color: WHITE_COLOR,
                            size: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                          ),
                          Text(
                            "Hi, ${appState.name}",
                            style: TextStyle(
                                color: WHITE_COLOR,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
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
            _getInventoryQuery(category: true),
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
                  'ORDERS',
                  style: TextStyle(color: WHITE_COLOR, fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourOrders()),
                  );
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
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesComponents(List<String> categories, BuildContext context) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final selected = categories[index] == selectedCategory;

          return Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(50)),
                color: selected ? WHITE_COLOR.withOpacity(.3) : null),
            padding: EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text(
                '${categories[index].toUpperCase()}',
                style: TextStyle(color: WHITE_COLOR, fontSize: 14),
              ),
              onTap: () {
                setState(() {
                  selectedCategory = categories[index];
                });
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  Widget _layout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _search(),
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: _catText("$selectedCategory")),
        _getInventoryQuery(),
        cartItems.length == 0 ? Container() : _bottomSheet(),
      ],
    );
  }

  Widget _getInventoryQuery({bool category = false}) {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getAllInventory,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 5,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getAllInventory'] != null) {
          List inventoryList = result.data['getAllInventory']['inventory'];
          final inventories = inventoryList
              .map((item) => InventoryItemModel.fromJson(item))
              .toList();
          categories =
              inventories.map((item) => item.category).toSet().toList();
          return category
              ? categoriesComponents(["All", ...categories], context)
              : _items(inventories);
        }
        return Container();
      },
    );
  }

  Widget _items(List<InventoryItemModel> inventories) {
    return Expanded(
        child: ListView.builder(
            itemCount: inventories.length,
            itemBuilder: (context, index) => _showItem(inventories[index])));
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
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
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

  Widget _showItem(InventoryItemModel inventory) {
    if (inventory.category != selectedCategory && selectedCategory != "All" ||
        query != "" &&
            !inventory.name.toLowerCase().contains(query.toLowerCase()))
      return Container();

    final inv = cartItems.firstWhere((f) => f['itemId'] == inventory.id,
        orElse: () => null);
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
                    "${inventory.name}",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    "Rs. ${inventory.price}/kg",
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: inv == null
                  ? _addFlatButton(inventory)
                  : _addOutLineButton(inventory)),
        ],
      ),
    );
  }

  Widget _addFlatButton(InventoryItemModel inventory) {
    final cartState = Provider.of<CartState>(context);
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
                    cartItems.add({
                      "name": inventory.name,
                      "item": inventory,
                      "itemId": inventory.id,
                      "quantity": 1,
                      "price": inventory.price
                    });
                    cartState.setCartItems(cartItems);
                    totalPrice += inventory.price;
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

  Widget _addOutLineButton(InventoryItemModel inventory) {
    final inv = cartItems.firstWhere((f) => f['itemId'] == inventory.id,
        orElse: () => null);

    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: 120,
              height: 48,
              child: OutlineButton(
                onPressed: () {},
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
                            inv["quantity"] -= 1;
                            totalPrice -= inventory.price;
                            inv["price"] -= inventory.price;

                            if (inv["quantity"] == 0)
                              cartItems.removeWhere(
                                  (item) => item["itemId"] == inventory.id);
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
                        "${inv["quantity"]}",
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
                            inv["quantity"] += 1;
                            inv["price"] += inventory.price;
                            totalPrice += inventory.price;
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
                    MaterialPageRoute(
                        builder: (context) => Cart(
                              cartItems: cartItems,
                              totalPrice: totalPrice,
                              clearCartItems: () {
                                setState(() {
                                  cartItems = [];
                                  totalPrice = 0;
                                });
                              },
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
                  "${cartItems.length} items in cart",
                  style: TextStyle(
                      fontSize: 14,
                      color: WHITE_COLOR,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs. $totalPrice",
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
