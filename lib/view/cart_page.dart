import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Customize the AppBar background color
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 14.sp, // Adjust font size for better appearance
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 15.h,
      ),
      body: Consumer<MenuViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            padding: EdgeInsets.all(2.w),
            itemCount: viewModel.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = viewModel.cartItems[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: ListTile(
                  title: Text(cartItem.key.name ?? '',
                      style: TextStyle(fontSize: 12.sp)),
                  subtitle: Text(
                    '${cartItem.value} x Rs. ${cartItem.key.price?.toStringAsFixed(2) ?? 'N/A'}',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, size: 8.w),
                    onPressed: () {
                      viewModel.removeFromCart(cartItem.key);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
