import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:moca_application/screens/contactprofileview.dart';
//import  'package:keyboard_actions/keyboard_actions.dart';



class ChatRoute extends StatefulWidget {
  final String messages;
  final String name;

  ChatRoute({Key key, @required this.messages, @required this.name}) : super(key: key);

  @override
  _ChatRouteState createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {

  ChatRoute get widget => super.widget;

  final messageController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      var messages = jsonDecode(widget.messages);
      var name = widget.name;
      print(widget.messages);


      return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              leading: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.grey[300],
              title: Text("$name"),
              actions: [
                FlutterLogo(size: 50),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    //TODO Navigate to ChatSettings
                    // Navigator.push(context
                    //MaterialPageRoute(builder: (context) => ChatSettings()),

                  },)
              ],
            ),
            body: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4.0),
                      child: ListTile(
                        title: Text(message["message"]["content"]),
                        trailing: Text('time sent'),

                        onTap: () async {},

                      ),
                    );
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const  EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                          child: TextField(
                            maxLines: 4,
                            minLines: 1,
                            controller: messageController,
                            decoration: InputDecoration(
                                hintText: 'Type here ...'
                            ),
                            autofocus: false,
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                      },
                      child: Text('icon'),
                    ),
                  ],
                ),
              ],
            ),
          ));
    }
  }



