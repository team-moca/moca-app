import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'apiInfo.dart';
import 'package:moca_application/api/apiInfo.dart';
import 'package:moca_application/helper/token.dart';
import 'dart:convert' show utf8;



class VerifyAccount {

  final URL = ApiInfo().url() + "/auth/verify";

  //for testing
  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  Future<http.Response> verify(String code, String username) async {


    final http.Response response = await http.post(
        ApiInfo().url()+"/auth/verify",
        headers: <String, String>{
        },
        body: jsonEncode({
          "username": username.toString(),
          "verification_code": code.toString()
        })
    );

    return response;


  }


}