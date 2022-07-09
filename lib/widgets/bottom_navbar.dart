import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/screens/map/recommendation.dart';
import 'package:final_project_mobile/screens/profile/profile.dart';
import 'package:final_project_mobile/screens/transaction/history.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class BottomNavbar extends StatelessWidget {
  final int current;
  BottomNavbar({Key? key, required this.current}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: CustomColor.whitebg,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: CustomColor.theme,
      unselectedItemColor: CustomColor.themedarker,
      currentIndex: current,
      showUnselectedLabels: false,
      onTap: (value) {
        switch (value) {
          case 0:
            Route route = MaterialPageRoute(builder: (context) => HomePage());
            Navigator.push(context, route);
            break;
          case 1:
            Route route = MaterialPageRoute(builder: (context) => RecommendationPage());
            Navigator.push(context, route);
            break;
          case 2:
            Route route = MaterialPageRoute(builder: (context) => HistoryPage());
            Navigator.push(context, route);
            break;
          case 3:
            Route route = MaterialPageRoute(builder: (context) => ProfilePage());
            Navigator.push(context, route);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(CupertinoIcons.home, size: 35),
        ),
        BottomNavigationBarItem(
          label: 'Navigasi',
          icon: Icon(CupertinoIcons.map, size: 35),
        ),
        BottomNavigationBarItem(
          label: 'Histori',
          icon: Icon(CupertinoIcons.calendar_circle, size: 35),
        ),
        BottomNavigationBarItem(
          label: 'Profil',
          icon: Icon(CupertinoIcons.person_fill, size: 35),
        ),
      ],
    );
  }
}
