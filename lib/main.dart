import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ViewModel/menu_view_model.dart';
import 'View/menu_page.dart';

void main() {
  runApp(RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuViewModel(),
      child: MaterialApp(
        title: 'Restaurant Menu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MenuPage(),
      ),
    );
  }
}
