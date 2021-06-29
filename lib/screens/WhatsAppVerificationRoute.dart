import 'package:flutter/material.dart';


class WhatsAppVerificationRoute extends StatefulWidget {

  final int connectorID;
  WhatsAppVerificationRoute({Key key, @required this.connectorID}) : super(key: key);


  @override
  _WhatsAppVerificationRoute  createState() => _WhatsAppVerificationRoute ();
}

class _WhatsAppVerificationRoute  extends State<WhatsAppVerificationRoute > {

  String code;
  final verificationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // chats come from Overview to _Overview
    // var chats = jsonDecode(widget.chats);
    var connectorId = widget.connectorID;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: Text(
            "VERIFY WHATSAPP",
            style: TextStyle(
              letterSpacing: 2.5,
            ),
          ),
          centerTitle: true,
        ),
          body: Center(
          child: Text(
              'Service created sucessfully. Please visit WhatsApp, open your settings and use"WhatsApp Web" - "Add device" to scan the QR-Code shown in the server log.'
          ),
        )
      ),
    );
  }
}
