import 'dart:convert';
import 'package:restaurant_menu/service/base_api_service.dart';
import 'package:restaurant_menu/service/network_api_service.dart';
import 'package:restaurant_menu/widgets/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<bool> loginAdmin(dynamic data) async {
    try {
      final response = await _apiServices.post(
        AppUrl.adminLogin,
        data,
        headers: {},  // Provide an empty headers map
      );
      Map<String, dynamic> jsonResponse = jsonDecode(response);
      String token = jsonResponse['token'];

      // Store the token in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('admin_token', token);

      return true;
    } catch (e) {
      // Handle or throw exceptions as needed
      return false;
    }
  }

  Future<void> logoutAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_token');
  }
}
