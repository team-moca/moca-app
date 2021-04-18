import 'package:flutter/material.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'package:moca_application/api/login.dart';
import 'package:http/http.dart' as http;
import 'package:moca_application/api/getChats.dart';
import 'dart:convert' as JSON;
import 'package:moca_application/database/getFromDatabase.dart';

import 'package:moca_application/helper/token.dart';


import 'package:moca_application/api/Authentication.dart';
import 'dart:async';

import 'package:moca_application/screens/RegistrationRoute.dart';




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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterRoute()),
          );        },
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
            ElevatedButton(
              onPressed: () async {
                print("hallo");
                http.Response response = await Login().login(usernameController.text, passwordController.text);
                //todo: check the response of Login().login -> if status code != 200 show error
                print("hallo");
                if(response.statusCode==200){
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => Overview(chats: chats)),
                    MaterialPageRoute(builder: (context) => AllChats()),
                  );
                }else if(500 <= response.statusCode && response.statusCode <= 600){
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Oops, the server is currently unreachable'),
                      );
                    },
                  );
                }else{
                  usernameController.clear();
                  passwordController.clear();
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Oops, username or password wrong'),
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        );


  }
}
