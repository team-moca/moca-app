//TODO content from API
import 'package:flutter/material.dart';

class VideoMessage {

  Widget createVideoMessage(message){

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
          text: TextSpan(
              text:("videos can not be displayed yet"),
            style: TextStyle(color: Colors.black),

          )
      ),
    );
  }
}