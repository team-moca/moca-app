import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
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
      URL+"?count=200",
      headers: <String, String>{
        "Authorization":"Bearer "+ token,
        "Content-Type": "application/json; charset=UTF-8",
      }
    );
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<String> getChat(chatId) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);


    final http.Response response = await http.get(
        URL+"/"+chatId.toString(),
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          "Content-Type": "application/json; charset=UTF-8",
        }
    );
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<String> getOwnId(chatId) async {

    var chatData = await getChat(chatId);
    print("getWonId in getcChats");
    var participants = jsonDecode(chatData)["participants"];

    for(var i = 0; i < participants.length; i++){
      if(participants[i]["is_self"]){
        return participants[i]["contact_id"].toString();
      }
    }
  }
}