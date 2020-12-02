import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Authentication{

  Future<String> getToken () async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

Future<String> refreshToken () async {
  final String URL = "http://127.0.0.1:5000/auth/refresh";
  final prefs = await SharedPreferences.getInstance();

  final http.Response response = await http.post(
    URL,
    headers: <String, String>{
      'Authorization': "Bearer "+ prefs.getString('token'),
    },
  );

  if (response.statusCode == 200) {

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', jsonDecode(response.body)["token"]);
    print("Token refreshed");
    return jsonDecode(response.body)["token"];

  } else {
    // throw an exception.
    throw Exception('Failed to refresh token');
    return null;
  }
  }

  Future decryptToken () async {
    final prefs = await SharedPreferences.getInstance();
    return decodeBase64(prefs.getString('token'));
  }

  String decodeBase64(String str) {
    //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) { // Pad with trailing '='
      case 0: // No pad chars in this case
        break;
      case 2: // Two pad chars
        output += '==';
        break;
      case 3: // One pad char
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

}