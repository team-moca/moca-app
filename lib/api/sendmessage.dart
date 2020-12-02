import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SendMessage {

  Future<String> textMessage(String messageContent, String chatId) async {

    final String URL="http://127.0.0.1:5000/chats/" + chatId + "/messages";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final http.Response response = await http.post(
      URL,
      headers: <String, String>{
        "Authorization":"Bearer "+ token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "message_id": 56183044,
        "contact_id": 1,
        "message": {
          "type": "text",
          "content": messageContent
        },
        "sent_datetime": "2020-11-11T09:02:30"
      }),
    );
    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception("Unable to send message");
      return null;
    }

  }

}