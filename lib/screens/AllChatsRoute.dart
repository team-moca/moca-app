import 'package:flutter/material.dart';
import 'package:moca_application/helper/token.dart';
import 'package:moca_application/screens/Chat.dart';
import 'package:moca_application/screens/NewConnectorCreation.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/NewChatRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/helper/TransformDatetime.dart';
import 'package:moca_application/helper/CreateAvatar.dart';
import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
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
      debugShowCheckedModeBanner: false,
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
                child: Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/mocaAppIcon.png",
                      height: 70,
                      width: 70,
                    ),
                    FutureBuilder(
                      future:  Token().getUsername(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        Widget children;
                        if (snapshot.hasData) {
                          var text = snapshot.data;
                          while(text==null){print("");}
                          children = Center(
                              child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        text,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                          ));
                        }else if (snapshot.hasError) {
                          children = Center(
                            child: Text("no username found"),
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
                  ],
                ),
                ),
                decoration: BoxDecoration(
                  color:  Colors.grey[300],
                ),
              ),
              ListTile(
                title: Text('Chats'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AllChats()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Add service'),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewConnectorCreation()));
                  },
                  // Update the state of the app.
                  // Navigator.pop(context);
              ),
              Divider(),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsRoute()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Log Out'),
                onTap:  () async {
                  await Logout().logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginRoute()));
                },
              ),
              Divider(),
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
                      if (snapshot.hasData && snapshot.data != null) {
                        var chats = jsonDecode(snapshot.data);
                        while(chats==null){print("");}
                        children = ListView.builder(
                          itemCount:chats.length,
                          itemBuilder: (context, index) {
                            var chat = chats[index]["name"];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                              child: Column(
                                children: [
                                  ListTile(
                                      title: Text("$chat"),
                                      leading: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.brown[400],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                  CreateAvatar().create(chats[index]["name"]),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      )
                                              ,
                                           ),
                                            )
                                          )
                                      ],
                                      ),
                                      //TODO: if last message is image or video, display text
                                      subtitle:Text (chats[index]["last_message"]["message"]["content"]!=null ? (chats[index]["last_message"]["message"]["content"]) : "Mediendatei"),
                                      //TODO: format text for time of last message -> time or days ago
                                      trailing: Text(TransformDatetime().date(chats[index]["last_message"]["sent_datetime"]),
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
                                  Divider()
                                ],
                              ),
                            );
                          },
                        );


                      }else if (snapshot.hasError) {
                        print("Could not load chats: "+snapshot.error.toString());

                        children = Center(
                            child:Container(
                                constraints: BoxConstraints(minWidth: 100, maxWidth: 250),
                                child: Text("Welcome to MOCA! You don't have any chats yet. Start by adding a new connector.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                )
                            )
                        );
                      }else {
                        if(snapshot.hasData){
                          children = Center(
                              child:Container(
                                  constraints: BoxConstraints(minWidth: 100, maxWidth: 250),
                                  child: Text("Welcome to MOCA! You don't have any chats yet. Start by adding a new connector.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  )
                                )
                          );
                        }else{
                        children = SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        }
                      }
                      return children;
                    },
                  ),
                )
                //TO HERE

              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.brown[400],
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
