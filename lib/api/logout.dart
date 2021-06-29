import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';


class Logout {

  final URL = ApiInfo().url() + "/auth/logout";


  Future<http.Response> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
          //'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    return response;

  }

}