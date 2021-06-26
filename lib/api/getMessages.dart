import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'apiInfo.dart';
import 'package:moca_application/api/apiInfo.dart';



class GetMessages {

  //for testing
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  Future<String> getMessages(int userId) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final URL = ApiInfo().url() + "/chats/"
                       + userId.toString() +"/messages";

    final http.Response response = await http.get(
        URL,
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          "Content-Type": "application/json; charset=UTF-8",
        }

    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      // throw an exception.
      throw Exception(response.statusCode);
      return null;
    }
  }

}