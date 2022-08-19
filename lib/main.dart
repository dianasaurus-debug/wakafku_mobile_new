
import 'package:final_project_mobile/screens/cobacoba.dart';
import 'package:final_project_mobile/screens/welcome/splash_screen.dart';
import 'package:final_project_mobile/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
            // primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            hintColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          home: Coba(),
          title: 'Kitsune',
          getPages: Routes().pages,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
        );
  }
}
