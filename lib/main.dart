import 'package:flutter/material.dart';
import 'package:moca_application/helper/initApplication.dart';
import 'package:moca_application/screens/LoginRoute.dart';
import 'package:moca_application/api/Authentication.dart';
import 'package:moca_application/screens/AllChatsRoute.dart';

void main() async {


    WidgetsFlutterBinding.ensureInitialized();
    runApp(MaterialApp(home: await InitApplication().init() ,
    ));
}


