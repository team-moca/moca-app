import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moca_application/api/Authentication.dart';
import 'dart:core';

class CreateAvatar {

    create(name){
      String initials = getInitials(name);
      //String colors = getColors(name);
      return initials;
    }

    String getInitials(name) {
      List firstLast = name.split(" ");
      if (firstLast.length>1){
        firstLast = [firstLast.first, firstLast.last];
        return firstLast[0][0]+firstLast[1][0];
      }else{
        firstLast = [firstLast.first];
        return firstLast[0][0];
      }
    }

    getColors(name){
      int color = int.fromEnvironment(name);
    }
}