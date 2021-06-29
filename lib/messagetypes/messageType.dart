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
                  text:("unknown messagetype"),

              )
          //TODO max width, bg color, padding, align left / right
        );
      }
      break;
    }

  }

  Future<Widget> whoIsOwner(String messageType,msg) async {

    int comparator = int.parse(await Token().yourId());
    if(msg["contact_id"] == comparator){
      return Container(
        padding: new EdgeInsets.fromLTRB(40, 4, 0, 0),
        child: Container(
            decoration: BoxDecoration(
            color:  Colors.grey[300],
    borderRadius: BorderRadius.circular(12),

    ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          identifyMessage(messageType,msg),
        ],
    )),
      );
    }else{
      return Container(
        padding: new EdgeInsets.fromLTRB(0, 4, 40, 0),
        child: Container(
            decoration: BoxDecoration(
        color: Colors.brown[200],
    borderRadius: BorderRadius.circular(12),
    ),
    child:identifyMessage(messageType,msg)),
      );
    }
  }
}