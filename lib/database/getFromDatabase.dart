import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:moca_application/database/database.dart';

class GetFromDatabase{

  Future<List> getAllChats() async {
    Database db = await Data().createDatabase();
    var result = await db.query("Chats", columns: ["chat_id", "contact_id", "name", "last_message", "connector_id", "is_muted"]);
    print("CHATS:");
    print(result);
    return result;
  }

  Future<List> getAllContacts() async {
    Database db = await Data().createDatabase();
    var result = await db.query("Contacts", columns: ["contact_id", "service_id", "phone", "name", "username", "avatar", "is_self"]);
    print("Contacts:");
    print(result);
    return result;
  }

  Future<List> getMessagesForContact(userId) async {
    Database db = await Data().createDatabase();
    var result = await db.query("Messages", columns: ["chat_id", "contact_id", "name", "last_message", "connector_id", "is_muted"], where: "contact_id = $userId");
    print("CHATS:");
    print(result);
    return result;
  }

//for debugging
  Future seeDatabase(userId) async {
    Database db = await Data().createDatabase();
    print("DATABASE:");
    print (await db.query("Chats", columns: ["chat_id", "contact_id", "name", "last_message", "connector_id", "is_muted"]));
    print (await db.query("Messages", columns: ["chat_id", "contact_id", "name", "last_message", "connector_id", "is_muted"], where: "contact_id = $userId"));
    print (await db.query("Contacts", columns: ["contact_id", "service_id", "phone", "name", "username", "avatar", "is_self"]));
  }
}