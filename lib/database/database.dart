import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/material.dart';



class Data{

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE Messages ("
        "message_id INTEGER PRIMARY KEY,"
        "contact_id INTEGER,"
        "message_type TEXT,"
        "message_content TEXT,"
        "message_url TEXT,"
        "sent_datetime TEXT"
        ")");


    await database.execute("CREATE TABLE Chats ("
        "chat_id INTEGER PRIMARY KEY,"
        "contact_id INTEGER,"
        "name TEXT,"
        "last_message TEXT,"
        "connector_id INTEGER,"
        "is_muted BOOL"
        ")");

    await database.execute("CREATE TABLE Contacts ("
        "contact_id INTEGER PRIMARY KEY,"
        "service_id INTEGER,"
        "phone  TEXT,"
        "name TEXT,"
        "username TEXT,"
        "avatar TEXT,"
        "is_self BOOL"
        ")");

  }

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'moca_db.db');

    Database database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

//should not be used anymore
  createChat(int chatId, String name, String chatType, String contactIds, int lastMessageId) async {
    Database db = await createDatabase();
    var result;
    result = await db.rawInsert(
        "INSERT INTO Chats (chat_id,name, chat_type, contact_ids, last_message_id)"
            " VALUES ($chatId, $name, $chatType, $contactIds, $lastMessageId)");
    return result;
  }


}