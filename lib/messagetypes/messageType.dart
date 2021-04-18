import 'package:flutter/material.dart';
import 'package:moca_application/messagetypes/textMessage.dart';
import 'package:moca_application/messagetypes/videoMessage.dart';
import 'package:moca_application/messagetypes/imageMessage.dart';
import 'package:moca_application/helper/token.dart';



class MessageType {

  Widget identifyMessage(String messageType,msg){


    var message = msg;
    switch(messageType) {
      case "text": {
        return TextMessage().createTextMessage(message) ;
      }
      break;

      case "image": {
        return ImageMessage().createImageMessage(message) ;
      }
      break;

      case "video": {
        return VideoMessage().createVideoMessage(message) ;
      }
      break;

      default: {
        return  RichText(
              text: TextSpan(
                  text:("what is dis?"),

              )
          //TODO max width, bg color, padding, align left / right
        );
      }
      break;
    }

  }

  Future<Widget> whoIsOwner(String messageType,msg) async {

    int comparator = await Token().yourId();
    if(msg["contact_id"] == comparator){
      return Container(
          decoration: BoxDecoration(
          color:  Color(0xffd5e1df),
    borderRadius: BorderRadius.circular(12),
    ),
    child:identifyMessage(messageType,msg));
    }else{
      return Container(
      decoration: BoxDecoration(
      color:  Color(0xffdeeaee),
    borderRadius: BorderRadius.circular(12),
    ),
    child:identifyMessage(messageType,msg));
    }
  }
}