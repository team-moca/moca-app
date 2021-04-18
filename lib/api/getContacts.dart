import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'apiInfo.dart';
import 'package:moca_application/api/apiInfo.dart';



class GetContacts {

  final URL = ApiInfo().url() + "/contacts";

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  Future<String> getContacts() async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');


    final http.Response response = await http.get(
        URL,
        headers: <String, String>{
          "Authorization":"Bearer " + token,
          "Content-Type": "application/json; charset=UTF-8",
        }

    );

    if (response.statusCode == 200) {
      //print(response.body);
      return response.body;
    } else {
      // throw an exception.
      throw Exception(response.statusCode);
      return null;
    }
  }

}