import 'package:flutter/material.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'package:moca_application/screens/NewConnectorCreation.dart';
import 'package:flutter/services.dart';
import 'package:moca_application/api/connectorSetup.dart';
import 'package:moca_application/api/connectorSetup.dart';
import 'package:moca_application/screens/Chat.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/NewChatRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';

import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/users.dart';
import 'package:moca_application/api/getChats.dart';



class WhatsAppVerificationRoute extends StatefulWidget {

  final int connectorID;
  WhatsAppVerificationRoute({Key key, @required this.connectorID}) : super(key: key);


  @override
  _WhatsAppVerificationRoute  createState() => _WhatsAppVerificationRoute ();
}

class _WhatsAppVerificationRoute  extends State<WhatsAppVerificationRoute > {

  String code;
  final verificationController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
    // var chats = jsonDecode(widget.chats);
    var connectorId = widget.connectorID;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "VERIFY WHATSAPP",
            style: TextStyle(
              letterSpacing: 2.5,
            ),
          ),
          centerTitle: true,
        ),

        /* drawer: Drawer(
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
        ),*/

        body: Center(
          child: Text(
              'Service created sucessfully. Please visit WhatsApp, open your settings and use"WhatsApp Web" - "Add device" to scan the QR-Code shown in the server log.'
          ),
        )
      ),
    );
  }
}
