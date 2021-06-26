import 'package:flutter/material.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:http/http.dart' as http;
import 'package:moca_application/api/registration.dart';


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
  final emailController = TextEditingController();
  final emailVerifyController = TextEditingController();




  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    emailVerifyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Enter your email'
              ),
            ),
            TextField(
              controller: emailVerifyController,
              decoration: InputDecoration(
                  labelText: 'Enter your email'
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (verifyInput(usernameController.text, passwordController.text , emailController.text,  emailVerifyController.text)){
                  http.Response response = await Register().register(usernameController.text , passwordController.text , emailController.text);
                  if(response.statusCode==200){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Account created'),
                          actions: <Widget>[
                            ElevatedButton(
                                child: Text('okidoki'),
                                onPressed: (){
                                  Navigator.pushReplacement(
                                    context,
                                    //MaterialPageRoute(builder: (context) => Overview(chats: chats)),
                                    MaterialPageRoute(builder: (context) => LoginRoute()),
                                  );
                                }
                            ),
                          ],
                        );
                      },
                    );
                  }else{
                    usernameController.clear();
                    passwordController.clear();
                    emailController.clear();
                    emailVerifyController.clear();

                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Oops, username already taken'),
                        );
                      },
                    );

                  }

                }else{
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Input does not fulfill requirements'),
                      );
                    },
                  );
                }

              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );

  }

  bool verifyInput(String username, String password , String email, String emailVerify){
    if(
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) &&
        email == emailVerify &&
        username.length>= 3 &&
        password.length >= 8

    ){
      return true;
    }else{
      return false;
    }

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
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text("Register"),
      ),
      body: Center(

        child: DataInput(),

      ),
    );
  }
}

