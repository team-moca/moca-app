import 'package:flutter/material.dart';
import 'package:moca_application/api/getContacts.dart';
import 'dart:convert';
import 'package:moca_application/helper/CreateAvatar.dart';


class NewChatRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text("START A NEW CHAT"),
      ),
      body: Center(
        child: FutureBuilder(
            future:  GetContacts().getContacts(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              Widget children;

              if (snapshot.hasData) {
                var contacts = jsonDecode(snapshot.data);
                while(contacts==null){print("");}
                children = ListView.builder(
                  itemCount:contacts.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    var contact = contacts[index]["name"];
                    if (contact.contains(" ") && contact.contains("None")){
                      contact = contact.split(" ");
                      print("contact");
                      print(contact);
                      contact.remove("None");
                      contact = contact.join(" ");
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("$contact"),

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
                                        CreateAvatar().create(contact),
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
                            trailing: Text(contacts[index]["service_id"],
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)),

                            onTap: () async {
                             /* var messages = await GetMessages().getMessages(contacts[index]["contact_id"]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatRoute(messages: messages, name: chats[index]["name"], chatId: chats[index]["chat_id"])),
                              );*/
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

                children = Container(
                  child: Text("oops - we could not receive any contacts",
                  style: TextStyle(
                    color: Colors.grey[300]
                  )),
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
      ),
    );
  }
}