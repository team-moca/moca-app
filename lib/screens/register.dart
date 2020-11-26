import 'package:flutter/material.dart';
import 'package:moca_application/screens/overview.dart';
import 'package:moca_application/api/login.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
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
              onPressed: () {
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );

  }
}

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
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