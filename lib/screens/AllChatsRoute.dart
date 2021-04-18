import 'package:flutter/material.dart';
import 'package:moca_application/screens/LoginChat.dart';
import 'package:moca_application/screens/NewConnectorRoute.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/NewChatRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/screens/NewConnectorRoute.dart';


import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/users.dart';
import 'package:moca_application/api/getChats.dart';



class AllChats extends StatefulWidget {
  //final String chats;
 // Overview({Key key, @required this.chats}) : super(key: key);

  @override
  _AllChats createState() => _AllChats();
}

class _AllChats extends State<AllChats> {

  //why do I need to do this?
  @override




  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
        ),

        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('display users name, initials and phone number'),
                decoration: BoxDecoration(
                  color:  Colors.grey[300],
                ),
              ),
              ListTile(
                title: Text('Add service'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewConnector()));
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsRoute()));
                },
              ),
              ListTile(
                title: Text('Log Out'),
                onTap:  () async {
                  await Logout().logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginRoute()));
                },
              ),
            ],
          ),
        ),

        body:Column(
          children: <Widget>[

            Expanded(
              child: SizedBox(
                height: 500,
                //FB HERE
                child:FutureBuilder(
                  future:  GetChats().getChats(),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      Widget children;

                      if (snapshot.hasData) {
                        print(snapshot.data.toString());
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
                                            print(snapshot.error);
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
                                  subtitle:Text (chats[index]["last_message"]["message"]["content"]!=null ? (chats[index]["last_message"]["message"]["content"]) : "Mediendatei"),
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
                        print("Could not load chats: "+snapshot.error.toString());

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
