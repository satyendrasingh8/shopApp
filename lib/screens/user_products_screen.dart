import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/providers/products.dart';
import 'package:shopApp/screens/edit_products_screen.dart';
import 'package:shopApp/widgets/app_drawer.dart';
import 'package:shopApp/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(productsData.items[i].id,
                      productsData.items[i].title,
                        productsData.items[i].imageUrl,
                        
                        ),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
