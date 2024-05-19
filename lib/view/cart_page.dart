import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 15.h,
      ),
      body: Consumer<MenuViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.w),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      Position position = await _determinePosition();
                      print(
                          'User Location: Lat: ${position.latitude}, Long: ${position.longitude}');
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Text('Proceed to Checkout',
                      style: TextStyle(fontSize: 14.sp)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
