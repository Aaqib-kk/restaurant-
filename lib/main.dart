import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'viewmodel/menu_view_model.dart';
import 'viewmodel/admin_view_model.dart';
import 'view/menu_page.dart';
import 'view/admin_login_page.dart';
import 'view/admin_menu_management_page.dart';

void main() {
  // Register the web implementation of the geolocator plugin.
  GeolocatorPlatform.instance = GeolocatorPlatform.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuViewModel()),
        ChangeNotifierProvider(create: (context) => AdminViewModel()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return RestaurantMenuApp();
        },
      ),
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
      initialRoute: '/',
      routes: {
        '/': (context) => MenuPage(),
        '/admin-login': (context) => AdminLoginPage(),
        '/admin-menu-management': (context) => AdminMenuManagementPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
