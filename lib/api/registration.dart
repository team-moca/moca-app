import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';


class Register {

  final URL = ApiInfo().url() + "/auth/register";


  Future<http.Response> register(String username, String password, String mail) async {

    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode({
          "username": username,
          "mail": mail,
          "password": password
        })
    );
    return response;
    if (response.statusCode == 200) {
      return response;
      //at this point the authentication was successful, the verification token is saved in shared preferences
    } else {
      print(response.statusCode);
      return response;
      return null;
    }

  }

}