import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateUsersApi {
  static Future<http.Response> createUser(String name, String job) async {
    final url = Uri.parse('https://reqres.in/api/users');
    final body = jsonEncode({
      "name": name,
      "job": job,
    });
    final response = await http.post(
      url,
      body: body,
    );
    return response;
  }
}
