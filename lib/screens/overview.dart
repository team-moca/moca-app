import 'package:flutter/material.dart';
import 'package:moca/screens/chat.dart';
import 'package:moca/screens/settings.dart';
import 'package:moca/screens/newchat.dart';
import 'package:moca/mockData.dart';


class Overview extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Overview> {
  //make this a list of chat items
  //getting the data will be async later
  var testdata = new MockData().getData();
  List chats =[];//make this list of chat previews



  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  //itemcount depends on nr of chats
                  itemCount:testdata["messages"].length,

                    itemBuilder: (context, index) {
                    print (chats);
                    var chat = testdata["messages"]["786123"]["content"];
                    var sender = testdata["name"];
                    var sent = testdata["messages"]["786123"]["senttime"];
                    //each is a chat
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                      child: Dismissible(
                        key: Key(chat),
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            chats.removeAt(index);
                            print(chats);
                          });
                        },
                        background: Container(color: Colors.redAccent[100]),
                        child: ListTile(
                          title: Text('$sender'),
                          leading: FlutterLogo(size: 56.0),
                            subtitle:Text('$chat'),//chatpreview name),
                            trailing: Text('$sent'),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatRoute("Nick")),
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
                    onPressed:(){
                      //depending on clicked chat
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
