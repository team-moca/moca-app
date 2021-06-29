import 'package:flutter/material.dart';
import 'package:moca_application/api/connectorSetup.dart';
import 'package:flutter/services.dart';
import 'package:moca_application/screens/TelegramVerificationRoute.dart';
import 'package:moca_application/screens/WhatsAppVerificationRoute.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'dart:convert';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/token.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';
import 'AllChatsRoute.dart';


class NewConnectorCreation extends StatefulWidget {

  @override
  _NewConnectorCreation  createState() => _NewConnectorCreation ();
}

class _NewConnectorCreation  extends State<NewConnectorCreation > {

  String phone;
  final phoneController = TextEditingController();
  String holder;
  String dropdownValue = 'Telegram';

  void getDropDownItem(){
    setState(() {
      holder = dropdownValue ;
    });
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = [false,false];

    // chats come from Overview to _Overview
    // var chats = jsonDecode(widget.chats);


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "NEW CONNECTOR",
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

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/apiImg.png",
                  height: 120,
                  width: 120,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: phoneController,
                        decoration: new InputDecoration(labelText: "Enter your phone number"),
                        keyboardType: TextInputType.number,
                        onChanged: (_){
                          setState(() {
                            phone = phoneController.text;
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                    ),
                  ),
                ],
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        items: <String>['WhatsApp', 'Telegram'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                    ],
                  ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.brown[400];}),
                    ),
                    child: Text(
                        "Create cconnector"
                    ),
                    onPressed: () async {
                      getDropDownItem();
                      phone = transformPhone(phone);

                      //todo: add whatsapp, does not work yet
                      String newConnector = await ConnectorSetup()
                          .createConnector(holder.toLowerCase());
                      if (newConnector != "") {
                        var connectorID = jsonDecode(newConnector)["connector_id"];
                        var result = await ConnectorSetup().setupConnector(connectorID, phone, jsonDecode(newConnector)["connector_type"]);

                        if (connectorID == "whatsapp") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                WhatsAppVerificationRoute(
                                    connectorID: connectorID)),
                          );
                        } else if (result == "telegram") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  TelegramVerificationRoute(
                                      connectorID: connectorID)),
                            );
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Oops, the server is currently unreachable'),
                                );
                              },
                            );
                          }

                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Oops, the server is currently unreachable'),
                            );
                          },
                        );
                      };
                    },
                  )
                ],
              ),
          ],
      ),
        ),
    )
    );
  }

  transformPhone(String phone){
    if(phone[0]=="0"){
      phone = "+49"+(phone.substring(1, phone.length));
    }
      return phone;
  }
}
