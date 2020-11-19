import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/providers/auth.dart';
import 'package:shopApp/models/providers/cart.dart';
import 'package:shopApp/models/providers/orders.dart';
import 'package:shopApp/models/providers/products.dart';
import 'package:shopApp/screens/auth_screen.dart';
import 'package:shopApp/screens/cart_screen.dart';
import 'package:shopApp/screens/edit_products_screen.dart';
import 'package:shopApp/screens/orders_screen.dart';
import 'package:shopApp/screens/product_detail_screen.dart';
import 'package:shopApp/screens/products_overview_screen.dart';
import 'package:shopApp/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth,Products>(
          update: (ctx,auth,previousProducts) => Products(
            auth.token,auth.userId,previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
          ChangeNotifierProxyProvider<Auth,Orders>(
          update: (ctx,auth,previousOrders) => Orders(
            auth.token,auth.userId,previousOrders==null ? [] :previousOrders.orders ),
        )
      ],
      child:Consumer<Auth>(builder: (ctx,authData,_) =>MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home:authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName:(ctx)=> CartScreen(),
          OrdersScreen.routeName:(ctx) => OrdersScreen(),  
          UserProductsScreen.routeName:(ctx) =>UserProductsScreen(),  
          EditProductScreen.routeName:(ctx)=> EditProductScreen(),
              },
      ) ,) 
    );
  }
}
