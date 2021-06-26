import 'package:flutter/material.dart';

class NewChatRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text("START NEW CHAT"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('hier ist noch Platz für verlorene Träume :('),
        ),
      ),
    );
  }
}