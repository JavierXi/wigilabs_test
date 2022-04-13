import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wigilabs/users_tab/models/user_model.dart';

class UsersApi {
  static Future<List<User>> getAllUsers() async {
    final url = Uri.parse('https://reqres.in/api/users?page=1');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data'] as List;
      List<User> tags = body.map((tagJson) => User.fromJson(tagJson)).toList();
      return tags;
    } else {
      throw Exception();
    }
  }

  static Future<User> getSingleUser(String user) async {
    final url = Uri.parse('https://reqres.in/api/users/$user');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data'];
      final result = User.fromJson(body);
      return result;
    } else {
      throw Exception();
    }
  }
}
