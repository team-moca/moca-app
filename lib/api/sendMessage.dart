import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'apiInfo.dart';
import 'package:moca_application/api/apiInfo.dart';


class SendMessage {

  Future<String> textMessage(String messageContent, int chatId) async {

    final URL= ApiInfo().url() + "/chats/" + chatId.toString() + "/messages";
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final http.Response response = await http.post(
      URL,
      headers: <String, String>{
        "Authorization":"Bearer "+ token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        //will be ignored
        "message_id": 56183044,
        //will be ignored
        "contact_id": 1,
        "message": {
          "type": "text",
          "content": messageContent
        },
        //will be ignored
        "sent_datetime": "2020-11-11T09:02:30"
      }),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Unable to send message");
    }

  }

}