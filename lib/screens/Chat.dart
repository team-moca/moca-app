import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:moca_application/messagetypes/messageType.dart';
import 'package:moca_application/api/sendMessage.dart';
import 'package:moca_application/helper/token.dart';
import 'package:flutter/gestures.dart';
import 'package:moca_application/screens/ContactViewRoute.dart';
import 'dart:async';


class ChatRoute extends StatefulWidget {
  final String messages;
  final String name;
  final int chatId;
  final chatMeta;
  final ownId;

  ChatRoute({Key key, @required this.messages, @required this.name, @required this.chatId, @required this.chatMeta, @required this.ownId}) : super(key: key);



  @override
  _ChatRouteState createState() => _ChatRouteState();
}


class _ChatRouteState extends State<ChatRoute> {

  ScrollController _scrollController = new ScrollController();
  final messageController = TextEditingController();
  int i= 0;
  int yourId;
  var messages;
  var name;
  var chatId;
  var chatMeta;
  var ownId;



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
        chatMeta = widget.chatMeta;
        ownId = widget.ownId;
        print(ownId);
      }

      return MaterialApp(
          debugShowCheckedModeBanner: false,
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
                title: RichText(
                  text:  TextSpan(
                      text: "$name",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactViewRoute(name: "$name", chatMeta: chatMeta))
                          );
                        },
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 2.5,
                      )),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: _refreshData,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];

                          return FutureBuilder(
                            future:  MessageType().whoIsOwner(message["message"]["type"], message, ownId, chatMeta),
                            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                              Widget child;
                              if (snapshot.hasData) {
                                child = snapshot.data;
                              }else if (snapshot.hasError) {
                                child = Text("oops, something went wrong");
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.brown[400],
                            onPressed: () async {
                              yourId = int.parse(await Token().yourId());
                              setState(() {
                                i=1;

                                if(messageController.text!=""){

                                  SendMessage().textMessage(messageController.text, chatId);

                                  messages.insert(0, {
                                    "message_id": messages[messages.length-1]["message_id"]-1,
                                    "contact_id": yourId,
                                    "message":{
                                      "type":"text",
                                      "content": messageController.text
                                    },
                                    "sent_datetime": DateTime.now()
                                  });

                                  _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                }
                              });

                              messageController.clear();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(Icons.arrow_right_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              return false;
            },
          ));
    }

  Future _refreshData() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {});
  }
  }
