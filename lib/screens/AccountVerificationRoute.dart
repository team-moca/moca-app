import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/api/VerifyAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountVerificationRoute extends StatefulWidget {

  @override
  _AccountVerificationRouteState createState() => _AccountVerificationRouteState();
}

class _AccountVerificationRouteState extends State<AccountVerificationRoute> {
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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DataInput(),
            ),
          ],
        ),
      ),
    );
  }
}


class DataInput extends StatefulWidget {
  @override
  _DataInput createState() => _DataInput();
}

class _DataInput extends State<DataInput> {
  final codeController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)  {
    return  Column(
      children: [
        TextField(
          controller: codeController,
          decoration: InputDecoration(
              labelText: 'Enter your verification code'
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            var username = prefs.getString('username');
            http.Response response = await VerifyAccount().verify(codeController.text, username);
            if(response.statusCode==200){
                showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context){
                return AlertDialog(
                title: Text('Your account has been created!'),
                actions: <Widget>[
                ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.brown[400];}),
                ),
                child: Text('Continue'),
                onPressed: () async {
                //MaterialPageRoute(builder: (context) => Overview(chats: chats)),
                MaterialPageRoute(builder: (context) => LoginRoute()
                );
                }
                ),
                ],
                );
                },
                );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginRoute()),
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
              codeController.clear();
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('Oops, your verification code was wrong.'),
                  );
                },
              );
            }
          },
          child: Text('Verify'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.brown[400];}),
          ),
        ),
      ],
    );
  }
}
