import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pazhamuthir_emart/screens/Auth/login.dart';
import 'package:pazhamuthir_emart/screens/home.dart';
import 'package:pazhamuthir_emart/state/app_state.dart';
import 'package:pazhamuthir_emart/state/cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;
  @override
  void initState() {
    _getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://pazhamudhir.herokuapp.com/',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink as Link,
      ),
    );
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
          child: ChangeNotifierProvider<AppState>(
        builder: (_) => AppState(),
        child: ChangeNotifierProvider<CartState>(
          builder: (_) => CartState(),
          child: MaterialApp(
            home: isAuthenticated ? HomeScreen() : Login(),
          ),
        ),
      )),
    );
  }

  _getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }
}
