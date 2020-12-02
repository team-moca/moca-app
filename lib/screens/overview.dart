import 'package:flutter/material.dart';
import 'package:moca_application/screens/chat.dart';
import 'package:moca_application/screens/settings.dart';
import 'package:moca_application/screens/newchat.dart';
import 'dart:convert';
import 'package:moca_application/api/getmessages.dart';
import 'package:moca_application/helper/users.dart';
import 'package:moca_application/api/getchats.dart';



class Overview extends StatefulWidget {
  //final String chats;
 // Overview({Key key, @required this.chats}) : super(key: key);

  @override
  _Overview createState() => _Overview();
}

class _Overview extends State<Overview> {

  //why do I need to do this?
  @override
  //Overview get widget => super.widget;




  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
   // var chats = jsonDecode(widget.chats);


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
                //FB HERE
                child:FutureBuilder(
                  future:  GetChats().getChats(),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      Widget children;
                      //print("XXXX"+snapshot.data);

                      if (snapshot.hasData) {
                        var chats = jsonDecode(snapshot.data);
                        while(chats==null){print("");}
                        children = ListView.builder(
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
                                      FutureBuilder(
                                        future: Users().getContactAvatar(chats[index]),
                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                          Widget children;
                                          if (snapshot.hasData) {
                                            children = Image.network(
                                              "${snapshot.data}",
                                              height: 40,);
                                          }else if (snapshot.hasError) {
                                            children = Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: 40,
                                            );
                                          }else {
                                            children = SizedBox(
                                              child: Icon(
                                                  Icons.account_circle_sharp,
                                                  size:40),
                                            );
                                          }
                                          return children;
                                        },
                                      ),
                                      //   )
                                    ],
                                  ),
                                  //TODO: if last message is image or video, display text
                                  subtitle:Text(chats[index]["last_message"]["message"]["content"]),
                                  //TODO: format text for time of last message -> time or days ago
                                  trailing: Text(chats[index]["last_message"]["sent_datetime"],
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10)),

                                  onTap: () async {
                                    var messages = await GetMessages().getMessages(chats[index]["chat_id"]);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatRoute(messages: messages, name: chats[index]["name"], chatId: chats[index]["chat_id"])),
                                    );
                                  },

                                ),
                              ),
                            );
                          },
                        );


                      }else if (snapshot.hasError) {
                        print("Could not load chats: "+snapshot.error);

                        children = Container(
                          child: Text("something went wrong, we could not receive any chats - TODO: case for chats are empty"),
                        );
                      }else {

                        children = SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return children;
                    },
                  ),
                )
                //TO HERE

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
