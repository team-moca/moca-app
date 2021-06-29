import 'package:flutter/material.dart';
import 'package:moca_application/helper/CreateAvatar.dart';
import 'package:moca_application/screens/Participants.dart';
import 'dart:convert';



class ContactViewRoute extends StatefulWidget {

  final String name;
  final chatMeta;

  ContactViewRoute({Key key, @required this.name, @required this.chatMeta}) : super(key: key);


  @override
  _ContactViewRouteState createState() => _ContactViewRouteState();
}

class _ContactViewRouteState extends State<ContactViewRoute> {
  var name;
  var chatMeta;

  @override
  Widget build(BuildContext context) {

    name = widget.name;
    chatMeta = widget.chatMeta;

    return Scaffold(

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
        elevation: 0,
        title: Text("$name"),
      ),
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: new BoxDecoration(
                    color: Colors.brown[400],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      CreateAvatar().create(name),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),

                    ),

                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 26
                ),
              ),
            ),
            Expanded(
              child: Participants().createParticipants(chatMeta),
            )
          ],
        )
      ),
    );
  }
}