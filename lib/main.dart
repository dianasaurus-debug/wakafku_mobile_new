
import 'package:final_project_mobile/screens/map/recommendation.dart';
import 'package:final_project_mobile/screens/welcome/splash_screen.dart';
import 'package:final_project_mobile/utils/routes.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/view_models/payment_vm.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'screens/program/waqf_form/payment_form.dart';
import 'utils/network.dart';
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<BaseNetwork>(
            create: (_) => BaseNetwork(),
          ),
          ChangeNotifierProvider<ProgramViewModel>(
            create: (_) => ProgramViewModel(),
          ),
          ChangeNotifierProvider<AuthViewModel>(
            create: (_) => AuthViewModel(),
          ),
          ChangeNotifierProvider<PaymentViewModel>(
            create: (_) => PaymentViewModel(),
          ),

        ],
        builder: (_, __) => OverlaySupport.global(
          child: GetMaterialApp(
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
            home: SplashScreenPage(),
            title: 'WakafKu',
            getPages: Routes().pages,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
          )
        ));
  }
}
