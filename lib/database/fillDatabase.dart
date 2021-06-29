import 'package:moca_application/api/getChats.dart';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/getContacts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';
import 'package:moca_application/database/database.dart';

class FillDatabase {

  void fillChats() async {
    try {
      Database db = await Data().createDatabase();
      var dataIn = jsonDecode(await GetChats().getChats());
      var name;
      var chatId;
      var connectorId;
      var isMuted;
      var contactId;
      var lastMessage;
      var localChats;

      for(var i = 0; i<dataIn.length; i++){
        chatId = (dataIn)[i]["chat_id"];
        contactId = (dataIn)[i]["contact_id"];
        name = (dataIn)[i]["name"];
        lastMessage = (dataIn)[i]["last_message"];
        connectorId = (dataIn)[i]["connector_id"];
        isMuted = (dataIn)[i]["is_muted"];
        var messageExists = false;

        localChats = await db.query("Chats", columns: ["chat_id","last_message"]);
        for (var j = 0; j<localChats.length; j++) {
          if (localChats[j]["chat_id"] == chatId) {
            messageExists = true;
            await db.rawUpdate(
                "UPDATE Chats SET last_message = ? WHERE chat_id = ?",
                ['$lastMessage', chatId]);
          }
        }
        if(messageExists==false){
          await db.rawInsert(
              "INSERT INTO Chats (chat_id, contact_id, name, last_message, connector_id, is_muted)"
                  " VALUES ($chatId, $contactId, '$name', '$lastMessage', '$connectorId', '$isMuted')");
        }
      }

      return;
    }on Exception {
      return;
    }
  }
  

  void fillMessages(userId) async {

     var messageId;
     var contactId;
     var type;
     var content;
     var url;
     var sent;
     var localMessages;

     try{
       Database db = await Data().createDatabase();
       var dataIn = jsonDecode(await GetMessages().getMessages(userId));


       for(var i = 0; i<dataIn.length; i++){

         messageId = (dataIn)[i]["message_id"];
         contactId = (dataIn)[i]["contact_id"];
         type = (dataIn)[i]["message"]["type"];
         content = (dataIn)[i]["message"]["content"];
         url = (dataIn)[i]["mesaage"]["url"];
         sent = (dataIn)[i]["sent"];
         var messageExists = false;

         localMessages = await db.query("Messages", columns: ["message_id"]);
         for (var j = 0; j<localMessages.length; j++) {
           if (localMessages[j]["message_id"] == messageId) {
             messageExists = true;
           }
         }
         if(messageExists==false){

           await db.rawInsert(
               "INSERT INTO Messages (message_id, contact_id, message_type, message_content, message_url, sent_datetime)"
                   " VALUES ($messageId, $contactId, '$type', '$content', '$url', '$sent')");
         }
       }
     } on Exception{
       return;
     }
  }




  void updateContacts() async {

    var serviceId;
    var name;
    var username;
    var phone;
    var avatar;
    var isSelf;
    var contactId;
    var localContacts;

    try{
      Database db = await Data().createDatabase();
      var dataIn = jsonDecode(await GetContacts().getContacts());

      print("fill ContactsTable from server");
      print(dataIn);

      for(var i = 0; i<dataIn.length; i++){

        serviceId = (dataIn)[i]["service_id"];
        name = (dataIn)[i]["name"];
        username = (dataIn)[i]["username"];
        phone = (dataIn)[i]["phone"];
        avatar = (dataIn)[i]["avatar"];
        isSelf = (dataIn)[i]["is_self"];
        contactId = (dataIn)[i]["contact_id"];
        var contactExists = false;

        localContacts = await db.query("Contacts", columns: ["contact_id"]);
        for (var j = 0; j<localContacts.length; j++) {
          if (localContacts[j]["contact_id"] == contactId) {
            //if user already exists in local db he will not be added again -> changes made to the user on server are not recognized
            //todo: will that become a problem?
            contactExists= true;
          }
        }
        if(contactExists==false){

          await db.rawInsert(
              "INSERT INTO Contacts (service_id, name, username, phone, avatar, is_self, contact_id)"
                  " VALUES ($serviceId, $name, '$username', '$phone', '$avatar', '$isSelf', '$contactId')");
        }

      }
    }on Exception{
      return;
    }


  }
}