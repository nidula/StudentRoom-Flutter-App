import 'dart:convert';
import 'dart:io';
import 'package:navigation_drawer_example/Models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class UserService extends Model{
  List<Users> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

  Future<List<Users>> getAllUsers() async {
    try {
      String url = "https://hivi-99-apigateway-gww2g.ondigitalocean.app/User";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Users> userList = parseUsers(response.body);
        if (userList.isNotEmpty) {
          return userList;
        } else {
          throw Exception('no users');
        }
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
}