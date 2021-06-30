import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moca_application/api/getChats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moca_application/messagetypes/textMessage.dart';
import 'package:moca_application/messagetypes/videoMessage.dart';
import 'package:moca_application/messagetypes/imageMessage.dart';
import 'package:moca_application/helper/token.dart';


class MessageType {

  Widget identifyMessage(String messageType,msg, token){


    var message = msg;
    switch(messageType) {
      case "text": {
        return TextMessage().createTextMessage(message) ;
      }
      break;

      case "image": {
        return ImageMessage().createImageMessage(message, token) ;
      }
      break;

      case "video": {
        return VideoMessage().createVideoMessage(message) ;
      }
      break;

      default: {
        return  Container(
          padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
              decoration: BoxDecoration(
                color:  Colors.brown[200],
                borderRadius: BorderRadius.circular(8),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("This message type is not yet supported.",
                  style: TextStyle(
                  ))
              ]),
    ));
      }
      break;
    }
  }

  Future<Widget> whoIsOwner(String messageType,msg, ownId, chatMeta) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if(msg["contact_id"].toString() == ownId.toString()){
      return Container(
        padding: new EdgeInsets.fromLTRB(40, 4, 0, 0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: identifyMessage(messageType,msg, token)),
      );
    }else{
      return Container(
        padding: new EdgeInsets.fromLTRB(0, 4, 40, 0),
        child: Container(
            decoration: BoxDecoration(
        color: Colors.brown[200],
    borderRadius: BorderRadius.circular(8),
    ),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowOwner(msg, chatMeta),
        identifyMessage(messageType,msg, token),
      ],
    )),
      );
    }
  }

  ShowOwner(msg, chatMeta){
    var participants = jsonDecode(chatMeta)["participants"];
    if(participants.length<=2){
      return Container();
        }else{
    for(var i = 0; i < participants.length; i++){
      print(participants[i]["contact_id"]);
      print(msg);
      if(participants[i]["contact_id"] == msg["contact_id"]){
        if (participants[i]["name"].contains(" ") && participants[i]["name"].contains("None")){
          participants[i]["name"] = participants[i]["name"].split(" ");
          participants[i]["name"].remove("None");
          participants[i]["name"] = participants[i]["name"].join(" ");
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 4, 0),
          child: Text(participants[i]["name"].toString()),
        );
          }
        }
    return Container();
    }
  }
}