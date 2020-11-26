import 'package:flutter/material.dart';
import 'package:moca_application/screens/chat.dart';
import 'package:moca_application/screens/settings.dart';
import 'package:moca_application/screens/newchat.dart';
import 'dart:convert';
import 'package:moca_application/api/getmessages.dart';



class Overview extends StatefulWidget {
  final String chats;
  Overview({Key key, @required this.chats}) : super(key: key);

  @override
  _Overview createState() => _Overview();
}

class _Overview extends State<Overview> {

  //why do I need to do this?
  @override
  Overview get widget => super.widget;




  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
    print(widget.chats);
    var chats = jsonDecode(widget.chats);


    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "MOCA",
            style: TextStyle(
              letterSpacing: 2.5,
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings), onPressed: (){
              //ERROR: Navigator operation requested with a context that does not include a Navigator.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsRoute()),
              );
            }
            )
          ],
          centerTitle: true,
        ),

        body:Column(
          children: <Widget>[

            Expanded(
              child: SizedBox(
                height: 500,
                //make list entries dismissibles
                child: ListView.builder(
                  itemCount:chats.length,

                    itemBuilder: (context, index) {
                    var chat = chats[index]["name"];
                    //each is a chat
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                      child: Dismissible(
                        //dismissible needs key to identify witch dismissible is meant
                        key: Key(chat),
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            //TODO: remove chat from screen
                            //TODO: call api with DELETE /chats/$id
                          });
                        },
                        background: Container(color: Colors.redAccent[100]),
                        child: ListTile(
                          title: Text("$chat"),
                          //TODO: replace flutter logo with chats' profile picture
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://freedesignfile.com/upload/2017/08/astronaut-icon-vector.png",
                                height: 40,
                              )
                            ],
                          ),
                            subtitle:Text('$chat'),
                            trailing: Text('time sent'),

                          onTap: () async {
                            var messages = await GetMessages().getMessages(chats[index]["chat_id"]);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatRoute(messages: messages, name: chats[index]["name"])),
                            );
                          },

                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.purple[300],
                    onPressed:()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewChatRoute()),
                      );
                    }
                    ,
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
