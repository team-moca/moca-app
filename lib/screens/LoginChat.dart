import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:moca_application/messagetypes/messageType.dart';
import 'package:moca_application/api/sendMessage.dart';
import 'package:moca_application/helper/token.dart';
import 'package:moca_application/helper/token.dart';
import 'package:moca_application/screens/ContactViewRoute.dart';
//import  'package:keyboard_actions/keyboard_actions.dart';



class ChatRoute extends StatefulWidget {
  final String messages;
  final String name;
  final int chatId;

  ChatRoute({Key key, @required this.messages, @required this.name, @required this.chatId}) : super(key: key);



  @override
  _ChatRouteState createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {

  final messageController = TextEditingController();
  int i= 0;
  int yourId;
  var messages;
  var name;
  var chatId;


  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {


      if(i==0){
        messages = jsonDecode(widget.messages);
        name = widget.name;
        chatId = widget.chatId;
      }




      return MaterialApp(
          home: WillPopScope(
            child: Scaffold(
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
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];

                        return FutureBuilder(
                          future:  MessageType().whoIsOwner(message["message"]["type"], message),
                          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                            Widget child;
                            if (snapshot.hasData) {
                              child = snapshot.data;
                            }else if (snapshot.hasError) {
                              child = Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 40,
                              );
                            }else {
                              child = SizedBox(
                                child: Icon(
                                    Icons.account_circle_sharp,
                                    size:40),
                              );
                            }
                            return  Padding(
                             padding: const EdgeInsets.symmetric(
                                 vertical: 2.0, horizontal: 4.0),
                             child:  child

                             );
                          },

                        );


                      },
                    ),
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
                      FloatingActionButton(
                        onPressed: () async {
                          print("send message button clicked");
                          yourId = await Token().yourId();
                          setState(() {
                            i=1;

                            if(messageController.text!=""){

                              SendMessage().textMessage(messageController.text, chatId);

                              messages.add({
                                "message_id": messages[messages.length-1]["message_id"]-1,
                                //TODO: contact_id should be own id, received from auth token -> write function for that
                                "contact_id": yourId,
                                "message":{
                                  "type":"text",
                                  "content": messageController.text
                                },
                                "sent_datetime": "2020-11-11T09:02:30"
                              });

                              print(messages.last);

                            }

                            //messages;
                          });

                          messageController.clear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.arrow_right_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            onWillPop: () async {
              return false;
            },

          ));
      
    }
  }



