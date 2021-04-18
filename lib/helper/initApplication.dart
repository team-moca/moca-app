import 'package:flutter/material.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'dart:async';
import 'package:moca_application/api/Authentication.dart';
import 'package:moca_application/database/fillDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:moca_application/database/database.dart';

class InitApplication{


  Future<Widget> init() async {
    print("init Application");
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token")!=null){
      Authentication().refreshToken();
      Data().createDatabase();
      FillDatabase().fillChats();
      return AllChats();

    }else{
      return LoginRoute();

    }

  }



}