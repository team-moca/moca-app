import 'package:flutter/material.dart';
import 'package:moca_application/api/connectorSetup.dart';
import 'package:flutter/services.dart';
import 'package:moca_application/screens/LoginChat.dart';
import 'package:moca_application/screens/SettingsRoute.dart';
import 'package:moca_application/screens/NewChatRoute.dart';
import 'package:moca_application/screens/LoginRoute.dart';

import 'dart:convert';
import 'package:moca_application/api/getMessages.dart';
import 'package:moca_application/api/logout.dart';
import 'package:moca_application/helper/users.dart';
import 'package:moca_application/api/getChats.dart';



class NewConnectorCreation extends StatefulWidget {

  //final String chats;
  // Overview({Key key, @required this.chats}) : super(key: key);

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
      home: Scaffold(
        backgroundColor: Colors.grey[100],

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

        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
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
              ],
            ),
                Row(
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
                  child: Text(
                      "Create cconnector"
                  ),
                  onPressed: () async {
                    getDropDownItem();
                    phone = transformPhone(phone);
                    print("AUSWAHL:+ $phone");

                    //todo: add whatsapp, does not work yet
                    String newConnector = await ConnectorSetup().createConnector(holder);
                    if(newConnector!=""){
                      var connectorID = jsonDecode(newConnector)["connector_id"];
                      var result  = await ConnectorSetup().setupConnector(connectorID, phone) ;
                      print(result);
                    }else{
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Oops, the server is currently unreachable'),
                          );
                        },
                      );
                    }

                  },
                ),
              ],
            ),
        ],
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
