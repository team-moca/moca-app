import 'package:http/http.dart' as http;

class Authentication {
  final String BASE_URL="http://127.0.0.1:5000/";

  Future<http.Response> login(String username, String hash, String deviceName) async {
    final http.Response response = await http.post(
      BASE_URL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        "username": "jkahnwald",
        "hash": "53fab271885be6d753d501940409376b94ca7b7a",
        "device_name": "MOCA Server API Playground"
      //"username": username,
      //"hash": hash,
      // "device_name": deviceName
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login');
    }
  }
}