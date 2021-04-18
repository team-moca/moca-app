import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';



class Login {

  final URL = ApiInfo().url() + "/auth/login";

  Future<http.Response> login(String username, String password) async {
    print("login initiated");

    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
              "grant-type": "password",
              "username": password,
              "password": username
        }
    );
    print("response.body");
    print(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)["access_token"]);
      print("Print token inside Login.dart: " + prefs.getString("token"));
      return response;
      //at this point the authentication was successful, the verification token is saved in shared preferences
    } else {
      return response;
    }

  }

}