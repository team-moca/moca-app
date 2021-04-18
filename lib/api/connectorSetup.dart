import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';


class ConnectorSetup{

  final URL = ApiInfo().url() + "/connectors";




  Future<String> setupConnector (int id, String phone) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final http.Response response = await http.put(
        URL + id.toString(),
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {}
    );

    if(jsonDecode(response.body)["connector_type"]=="telegram"){
      bool isPhoneVerified = await setupTelegramPhone(id, phone);
      if(isPhoneVerified){
        
      }


    }else if(jsonDecode(response.body)["connector_type"]=="whatsapp"){

    }else{
      return"";
    }
    //todo: check if response is for telegram or whatsapp
    //call whatsapp or telegram setup
  }

  Future<String> createConnector (String type) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');


    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"connector_type": type})
    );
    print("response.body");
    print(response.body);

    if(response.statusCode == 200){
      return response.body;
    }else{
      return "";
    }
  }


  Future<bool> setupTelegramPhone(id, phone) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final http.Response response = await http.put(
        URL + id.toString(),
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          "phone" : phone
        }
    );
    if(response.statusCode==200){
      return true;
    }
    else return false;
  }

  Future<http.Response> setupWhatsApp (){



  }

}