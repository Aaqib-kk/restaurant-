import 'package:flutter/material.dart';
import 'package:restaurant_menu/models/menu_item.dart';

class MenuItemDetailPage extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemDetailPage({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menuItem.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              menuItem.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '\$${menuItem.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
