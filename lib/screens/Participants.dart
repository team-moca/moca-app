import 'package:flutter/material.dart';
import 'package:moca_application/helper/token.dart';
import 'package:moca_application/screens/Chat.dart';
import 'package:moca_application/screens/NewConnectorCreation.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/helper/TransformDatetime.dart';
import 'package:moca_application/helper/CreateAvatar.dart';
import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/api/getChats.dart';

class Participants{

  Widget createParticipants (chatMeta){

    var participants = jsonDecode(chatMeta)["participants"];
    if(participants.length <= 2){
      return Text("");
    }

    for (int i = 0; i < participants.length; i++){
      if (participants[i]["name"].contains(" ") && participants[i]["name"].contains("None")){
        participants[i]["name"] = participants[i]["name"].split(" ");
        print("contact");
        print(participants[i]["name"]);
        participants[i]["name"].remove("None");
        participants[i]["name"] = participants[i]["name"].join(" ");
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Participants:",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 20
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: participants.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('${participants[index]["name"]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16
                ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}