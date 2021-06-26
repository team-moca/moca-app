import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';



class Login {

  final URL = ApiInfo().url() + "/auth/login";

  Future<http.Response> login(String username, String password) async {

    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
        },
        body: <String, String>{
              "grant-type": "password",
              "username": username,
              "password": password
        }
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)["access_token"]);
      }
      return response;

  }

}