import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Login {

  final String BASE_URL="http://127.0.0.1:5000/auth/login";

  Future<http.Response> login(String username, String hash, String deviceName) async {
print("login initiated");
    //TODO When user clicks login submit the following method actually gets called 2 times. Why?

    final http.Response response = await http.post(
      BASE_URL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        //NOTE: Use of the proper input field works and is in comments for easier testing
        //"username": username,
        //"hash": hash,
      "username": "jkahnwald",
      "hash": "53fab271885be6d753d501940409376b94ca7b7a",
       "device_name":  "MOCA Server API Playground"
      }),
    );
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)["token"]);
      print("Print token inside Login.dart: " + prefs.getString("token"));
      return response;
      //at this point the authentication was successful, the verification token is saved in shared preferences
    } else {
      // TODO: Notify user that login was unsuccesfull
      throw Exception('Failed to login');
      return null;
    }

  }

}