import 'dart:convert';
import 'package:http/http.dart' as http;
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
  }
}