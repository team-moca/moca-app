import 'package:flutter/material.dart';
import 'package:moca_application/screens/overview.dart';
import 'package:moca_application/api/login.dart';
import 'package:moca_application/api/getchats.dart';
import 'dart:convert' as JSON;

import 'package:moca_application/api/Authentication.dart';
import 'dart:async';




class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login screen"),
      ),
      body: Center(

        child:  DataInput(),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Sign up'),

      ),
    );
  }
}


class DataInput extends StatefulWidget {
  @override
  _DataInput createState() => _DataInput();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _DataInput extends State<DataInput> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)  {
    return  Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Enter your username'
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Enter your password'
              ),
              obscureText: true,
              autofocus: false,
            ),
            RaisedButton(
              onPressed: () async {
                await Login().login(usernameController.text, passwordController.text, "devicename");
                var chats = await GetChats().getChats();

                Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) => Overview(chats: chats)),
                 );
              },
              child: Text('Login'),
            ),
          ],
        );


  }
}
