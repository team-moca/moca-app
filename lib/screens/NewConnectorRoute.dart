import 'package:flutter/material.dart';
import 'package:moca_application/screens/NewConnectorCreation.dart';
import 'package:moca_application/screens/LoginChat.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/NewChatRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';

import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/users.dart';
import 'package:moca_application/api/getChats.dart';



class NewConnector extends StatefulWidget {
  //final String chats;
  // Overview({Key key, @required this.chats}) : super(key: key);

  @override
  _NewConnector  createState() => _NewConnector ();
}

class _NewConnector  extends State<NewConnector > {


  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
    // var chats = jsonDecode(widget.chats);


    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "CONNECTORS",
            style: TextStyle(
              letterSpacing: 2.5,
            ),
          ),
          centerTitle: true,
        ),

        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('display users name, initials and phone number'),
                decoration: BoxDecoration(
                  color:  Colors.grey[300],
                ),
              ),
              ListTile(
                title: Text('Add service'),
                onTap: () {
                  // Update the state of the app.
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsRoute()));
                },
              ),
              ListTile(
                title: Text('Log Out'),
                onTap:  () async {
                  await Logout().logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginRoute()));
                },
              ),
            ],
          ),
        ),

        body: Column(
          children: [
            Text("connectors will be shown here"),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Add new connector"
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewConnectorCreation()));
                    },
                  ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
