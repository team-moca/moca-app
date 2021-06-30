import 'package:flutter/material.dart';
import 'package:moca_application/helper/token.dart';

class ImageMessage {

  Widget createImageMessage(message, token) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.network(
        "https://moca.vigonotion.com"+message["message"]["url"].toString(),
          headers: <String, String>{
            "Authorization":"Bearer "+ token,
          },
          loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: Text('Loading...'));
          // You can use LinearProgressIndicator or CircularProgressIndicator instead
        },
        errorBuilder: (context, error, stackTrace) =>
            Text('Some error occurred!'),
        height: 500,
      )
    );
  }
}