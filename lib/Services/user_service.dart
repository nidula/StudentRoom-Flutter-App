import 'dart:convert';
import 'package:navigation_drawer_example/Models/user_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class UserService extends Model{
  List<Users> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

  Future<List<Users>> getAllUsers() async {
    try {
      String url = "https://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Users";
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

  Future<Users> getUserByCredentials(int id,String pw) async {
    try {
      String url =
          "https://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Users/GetUserByCredentials/$id/$pw";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Users> userList = parseUsers(response.body);
        if (userList.isNotEmpty) {
          return userList[0];
        } else {
          throw Exception('no user found with this Credentials');
        }
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

Future<int> loginUser(String id, String password) async {

    int d = int.parse(id);
    Users user = await getUserByCredentials(d,password);
    if (user != null) {
      return user.uId;
    } else {
      throw Exception('Invalid Credentials!');
    }
  }

}