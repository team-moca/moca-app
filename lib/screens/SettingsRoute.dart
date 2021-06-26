import 'package:flutter/material.dart';
import 'package:moca_application/api/logout.dart';

import 'AllChatsRoute.dart';
import 'LoginRoute.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text("SETTINGS"),
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
              title: Text('Chats'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AllChats()));
              },
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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}