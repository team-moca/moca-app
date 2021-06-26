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



class TelegramVerificationRoute extends StatefulWidget {

  final int connectorID;
  TelegramVerificationRoute({Key key, @required this.connectorID}) : super(key: key);


  @override
  _TelegramVerificationRoute  createState() => _TelegramVerificationRoute ();
}

class _TelegramVerificationRoute  extends State<TelegramVerificationRoute > {

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
            "VERIFY TELEGRAM",
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

        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: verificationController,
                    decoration: new InputDecoration(labelText: "Enter your verification code"),
                    keyboardType: TextInputType.number,
                    onChanged: (_){
                      setState(() {
                        code = verificationController.text;
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
              ],
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                      "Verify"
                  ),
                  onPressed: () async {
                    var isTelegramVerified = await ConnectorSetup().setupTelegramVerification(connectorId, code);
                    if (isTelegramVerified){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AllChats())
                      );
                    }
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
