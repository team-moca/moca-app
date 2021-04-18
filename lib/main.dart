import 'package:flutter/material.dart';
import 'package:moca_application/helper/initApplication.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/api/Authentication.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';


void main() async {


    WidgetsFlutterBinding.ensureInitialized();
    runApp(MaterialApp(home: await InitApplication().init() ,
    ));

  //check if user already logged in on this device


  //now running chat overview
  //TODO add splash screen through launch_background.xml ()
  //TODO check if initial login route should be used --> tutorial , initial setup

}


