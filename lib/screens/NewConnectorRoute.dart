import 'package:flutter/material.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'package:moca_application/screens/NewConnectorCreation.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/token.dart';


class NewConnector extends StatefulWidget {
  //final String chats;
  // Overview({Key key, @required this.chats}) : super(key: key);

  @override
  _NewConnector  createState() => _NewConnector ();
}

class _NewConnector  extends State<NewConnector > {


  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
    // var chats = jsonDecode(widget.chats);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "CONNECTORS",
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
                      "assets/connector.png",
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
              child: Text("You have not set up any connectors yet."),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Add new connector"
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewConnectorCreation()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.brown[400];}),
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
