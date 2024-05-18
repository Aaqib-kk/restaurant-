abstract class BaseApiServices {
  Future<dynamic> get(String url, {required Map<String, String> headers});
  Future<dynamic> post(String url, dynamic body);
  Future<dynamic> put(String url, dynamic body);
  Future<dynamic> patch(String url, dynamic body,
      {required Map<String, String> headers});
  Future<dynamic> delete(String url);
}
