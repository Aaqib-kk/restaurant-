import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: viewModel.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = viewModel.cartItems[index];
          return ListTile(
            title: Text(cartItem.key.name),
            subtitle: Text('${cartItem.value} x \$${cartItem.key.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                viewModel.removeFromCart(cartItem.key);
              },
            ),
          );
        },
      ),
    );
  }
}
