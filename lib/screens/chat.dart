import 'package:flutter/material.dart';
import 'package:moca/screens/contactprofileview.dart';
import  'package:keyboard_actions/keyboard_actions.dart';



class ChatRoute extends StatefulWidget {
  ChatRoute(String name){
  }

  @override
  _ChatRouteState createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {

  var test = new Message("Lorem Ipsum",Colors.red[100]);
  var test2 = new Message("Lorem Ipsum",Colors.grey[200]);
  var test3 = new Message("Lorem Ipsum",Colors.blue[100]);
  var test4 = new Message("Lorem Ipsum",Colors.grey[200]);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          backgroundColor: Colors.grey[300],
          title: Text("Nick"),
        actions: [
          FlutterLogo(size: 50),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              //TODO Navigate to ChatSettings
             // Navigator.push(context
              //MaterialPageRoute(builder: (context) => ChatSettings()),

            },)
        ],
        ),
        body: ListView(
          children: [

          test, test2, test3, test4,
            test, test2, test3, test4,

              TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
              hintText: "Message",
              ),

        )
    ],
      ),
    ));
  }
}

class Message extends StatelessWidget{
  String cont;
  Color color;
  Message( this.cont, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Container(
          height: 50,
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  cont,
                   style: TextStyle(
                    fontSize: 18
                ),),
              //TODO add loading/sent Icons
            ],
          )
      ),
    );
  }
}


//darstellung anhand des senders
//-> Message Class return für owner true/false unterschiedlich (im design)



