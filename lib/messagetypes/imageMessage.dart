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
        "https://images.cdn3.stockunlimited.net/preview1300/astronaut-avatar_1408749.jpg",
        height: 250,
      )
      //TODO max width, bg color, padding, align left / right
    );
  }
}