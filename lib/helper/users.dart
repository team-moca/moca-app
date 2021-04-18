import 'package:moca_application/helper/token.dart';

class Users {

  Future<String> getContactAvatar(chat) async {
    for (int i=0;i<chat["contacts"].length;i++) {
      if(chat["contacts"][i]["is_moca_user"]){
        if (chat["contacts"][i]["avatar"]==null){
          return("https://freedesignfile.com/upload/2017/08/astronaut-icon-vector.png");
        }
        return chat["contacts"][i]["avatar"];
      }
      else return("https://freedesignfile.com/upload/2017/08/astronaut-icon-vector.png");
    }
  }

  String getUserName(chat){
    return "";
  }



  String getOwnAvatar(){
    return "";
  }
}