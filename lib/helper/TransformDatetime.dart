import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moca_application/api/Authentication.dart';

class TransformDatetime {

  String date(time) {
    var messageTime = DateTime.parse(time);
    var currentTime = DateTime.now();
    var difference = currentTime.difference(messageTime);
    var day =  Duration(days: 1);
    var twoDays = Duration(days: 2);
    if(difference >= twoDays){
      return(messageTime.day.toString() + "." + (messageTime.month.toString().length == 1 ? "0" :"" )+ messageTime.month.toString());
    }
    if(difference >= day){
      return("Gestern");
    }
    if(difference < day){
      return(messageTime.hour.toString() + ":"+messageTime.minute.toString() );
    }

  }
}