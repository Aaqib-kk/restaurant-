import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/viewmodel/admin_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminMenuManagementPage extends StatefulWidget {
  @override
  _AdminMenuManagementPageState createState() =>
      _AdminMenuManagementPageState();
}

class _AdminMenuManagementPageState extends State<AdminMenuManagementPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('admin_token');
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/admin-login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AdminViewModel>(context, listen: false)
                  .logoutAdmin();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Admin Menu Management Page'),
      ),
    );
  }
}
