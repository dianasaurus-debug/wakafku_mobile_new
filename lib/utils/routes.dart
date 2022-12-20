import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/screens/welcome/splash_screen.dart';
import 'package:get/route_manager.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Routes {
  List<GetPage> pages = <GetPage>[
    GetPage(
      name: '/',
      page: () => SplashScreenPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    )

  ];
}
