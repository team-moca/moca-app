import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class GetMessages {

  //for testing
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  Future<String> getMessages(String userId) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final String URL="http://127.0.0.1:5000/chats/"+ userId +"/messages";


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
      throw Exception('Error occured while getting your chats');
      return null;
    }
  }

}