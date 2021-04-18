//TODO content from API
import 'package:flutter/material.dart';

class TextMessage {

  Widget createTextMessage(message){

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text:(message["message"]["content"]),
                  style: TextStyle(color: Colors.black),
                )
              ),
            ],
          ),
        ),
    );
  }
}