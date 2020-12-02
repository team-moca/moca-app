import 'package:moca_application/helper/token.dart';

class Users {

  Future<String> getContactAvatar(chat) async {
    var ownId = await Token().decryptToken();
    var i = 0;
    while (true) {
      if(chat["contacts"][i]["contact_id"]!=ownId["user_id"]){
        return chat["contacts"][i]["avatar"];
      }
      i+=1;
    }
  }

  String getUserName(chat){
    return "";
  }



  String getOwnAvatar(){
    return "";
  }
}