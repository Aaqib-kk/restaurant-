import 'dart:convert';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/service/base_api_service.dart';
import 'package:restaurant_menu/service/network_api_service.dart';
import 'package:restaurant_menu/widgets/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class MenuRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<MenuItem>> getMenu() async {
    try {
      final response = await _apiServices.get(AppUrl.getMenu, headers: {});
      List<dynamic> jsonResponse = jsonDecode(response);
      List<MenuItem> menuItems = jsonResponse.map((item) => MenuItem.fromJson(item)).toList();
      return menuItems;
    } catch (e) {
      // Handle or throw exceptions as needed
      rethrow;
    }
  }

  Future<void> createMenuItem(MenuItem menuItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('admin_token');
    try {
      await _apiServices.post(
        AppUrl.createMenu,
        jsonEncode(menuItem.toJson()),
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      // Handle or throw exceptions as needed
      rethrow;
    }
  }

  Future<void> updateMenuItem(MenuItem menuItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('admin_token');
    try {
      await _apiServices.put(
        '${AppUrl.updateMenu}/${menuItem.sId}',
        jsonEncode(menuItem.toJson()),
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      // Handle or throw exceptions as needed
      rethrow;
    }
  }

  Future<void> deleteMenuItem(String menuItemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('admin_token');
    try {
      await _apiServices.delete(
        '${AppUrl.deleteMenu}/$menuItemId',
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      // Handle or throw exceptions as needed
      rethrow;
    }
  }

  Future<String> uploadImage(Uint8List imageBytes) async {
  var request = http.MultipartRequest('POST', Uri.parse(AppUrl.uploadImage));
  request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: 'upload.jpg'));

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);
    return jsonResponse['imageUrl'];
  } else {
    throw Exception('Failed to upload image');
  }
}
}
