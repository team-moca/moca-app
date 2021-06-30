import 'package:flutter/material.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'package:moca_application/api/login.dart';
import 'package:http/http.dart' as http;
import 'package:moca_application/screens/RegistrationRoute.dart';


class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              "assets/mocaAppIcon.png",
              height: 120,
              width: 120,
            ),

            Center(
                child:Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 250),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,20, 0, 0),
                      child: Text("Welcome to MOCA. It´s nice to see you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DataInput(),
            ),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterRoute()),
          );        },
        label: Text('Sign up'),
        backgroundColor: Colors.brown[400],

      ),
    );
  }
}


class DataInput extends StatefulWidget {
  @override
  _DataInput createState() => _DataInput();
}

class _DataInput extends State<DataInput> {
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
                http.Response response = await Login().login(usernameController.text, passwordController.text);
                if(response.statusCode==200){
                  Navigator.pushReplacement(
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
                        title: Text('Oops, the server is currently unreachable.'),
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
                        title: Text('Oops, username or password wrong.'),
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.brown[400];}),
              ),
            ),
          ],
        );
  }
}
