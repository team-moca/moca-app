//TODO content from API
import 'package:flutter/material.dart';

class VideoMessage {

  Widget createVideoMessage(message){

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
          text: TextSpan(
              text:("Videos can not be displayed yet"),
            style: TextStyle(color: Colors.black),

          )
      ),
    );
  }
}