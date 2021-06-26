import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'apiInfo.dart';
import 'package:moca_application/api/apiInfo.dart';
import 'dart:convert' show utf8;



class GetChats {

  final URL = ApiInfo().url() + "/chats";

  //for testing
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  Future<String> getChats() async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);


    final http.Response response = await http.get(
      URL,
      headers: <String, String>{
        "Authorization":"Bearer "+ token,
        "Content-Type": "application/json; charset=UTF-8",
      }
    );
    if (response.statusCode == 200) {
      print("BODY");
      print(response.body);
      return response.body;
    } else {
      throw Exception(response.statusCode);
    }
  }

}