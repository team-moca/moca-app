import 'package:flutter/material.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/api/Authentication.dart';
import 'package:moca_application/screens/overview.dart';

class InitApplication{

  Future<Widget> isLoggedIn() async {

    var token = await Authentication().getToken();

    if(token!=null){
      return Overview();
    }else{
      return LoginRoute();
    }
  }

}