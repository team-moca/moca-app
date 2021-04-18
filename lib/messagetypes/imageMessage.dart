//TODO content from API
import 'package:flutter/material.dart';

class ImageMessage {

  Widget createImageMessage(message){

    print(message);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.network(
        message["message"]["url"],
        height: 250,
      )
      //TODO max width, bg color, padding, align left / right
    );
  }
}