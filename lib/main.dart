import 'package:flutter/material.dart';
import 'package:moca/screens/overview.dart';
import 'package:moca/screens/login.dart';



void main() {

  //now runing chat overview
  //TODO add splash screen through launch_background.xml ()
  //TODO check if initial login route should be used --> tutorial , initial setup
  //runApp(MaterialApp(home: Overview(
  runApp(MaterialApp(home: LoginRoute(


  ),
  ));
}
