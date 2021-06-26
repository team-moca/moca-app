import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/api/apiInfo.dart';


class ConnectorSetup{

  final URL = ApiInfo().url() + "/connectors";




  Future<String> setupConnector (int id, String phone, String service) async {

    print("SETUP CONNECTOR");

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print(URL + "/" + id.toString());

    final http.Response response = await http.put(
        URL + "/$id",
        //URL + "/19",
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode({})
    );

    if(service=="telegram"){
      bool isPhoneVerified = await setupTelegramPhone(id, phone);
      print("isPhoneVerified: $isPhoneVerified");

      if(isPhoneVerified){
        print("RETURN TELEGRAM in setupConnector");
        return"telegram";
      }


    }else if(jsonDecode(response.body)["connector_type"]=="whatsapp"){
      return"whatsapp";
    }else{
      return"";
    }
  }

  Future<String> createConnector (String type) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print("TOKEN");
    print(token);


    final http.Response response = await http.post(
        URL,
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"connector_type": type})
    );
    print("CREATE CONNECTOR RETURNS:");
    print(response.body);

    if(response.statusCode == 200){
      return response.body;
    }else{
      print("o nooooooooo");
      return "";
    }
  }


  Future<bool> setupTelegramPhone(id, String phone) async {
    print("STARTED SEUP TELEGRAM PHONE WITH:");
    print("PHONE:" + phone);
    print("ID:" + id.toString());
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print("setupTelegramPhone");
    print(URL + "/" + id.toString());
    print(phone);

    final http.Response response = await http.put(
        URL + "/" + id.toString(),
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "phone" : "+4917634614265"
        })
    );
    print(response.body);


    if(response.statusCode==200){
      return true;
    }
    else return false;
  }

  Future<bool> setupTelegramVerification(int id,String code) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final http.Response response = await http.put(
        URL + "/" + id.toString(),
        headers: <String, String>{
          "Authorization":"Bearer "+ token,
          //'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "verification_code" : code
        })
    );
    print (jsonDecode(response.body));

    if(response.statusCode==200)return true;
    else return false;
  }


  Future<http.Response> setupWhatsApp (){
  }

}