import 'package:flutter/material.dart';

class TextMessage {

  Widget createTextMessage(message){

    return Padding(
      padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              message["message"]["content"],
              style: TextStyle(
                fontSize: 16,
                  color: Colors.black
              ),
              textAlign: TextAlign.left,
            ),
          ),
    );
  }
}