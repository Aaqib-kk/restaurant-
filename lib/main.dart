// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/menu_view_model.dart';
import 'view/menu_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MenuViewModel(),
      child: RestaurantMenuApp(),
    ),
  );
}

class RestaurantMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}
