import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SecondAppBar(appBar: AppBar(), title : 'Profil'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child : Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/images/mosque_pic.jpg'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text('Diana Fitri', style: CustomFont.blackMedBold),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: CustomColor.themedarker,
                          borderRadius : BorderRadius.circular(10.0)
                      ),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('2', style: CustomFont.whiteMedBold),
                          SizedBox(height: 8),
                          Text('Wakaf', style: CustomFont.whiteMedBold,)
                        ],
                      )
                  )
                ),
                SizedBox(width : 5),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: CustomColor.themedarker,
                            borderRadius : BorderRadius.circular(10.0)
                        ),
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Rp 200k', style: CustomFont.whiteMedBold),
                            SizedBox(height: 8),
                            Text('Wakaf', style: CustomFont.whiteMedBold,)
                          ],
                        )
                    )
                ),
                SizedBox(width : 5),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: CustomColor.themedarker,
                            borderRadius : BorderRadius.circular(10.0)
                        ),
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('2', style: CustomFont.whiteMedBold),
                            SizedBox(height: 8),
                            Text('Wakaf', style: CustomFont.whiteMedBold,)
                          ],
                        )
                    )
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 20),
              child: GestureDetector(
                onTap: () {

                },
                child: Row(
                  children: [
                    Icon(
                      const IconData(58513, fontFamily: 'MaterialIcons'),
                      color: CustomColor.theme,
                      size : 28,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Akun saya', style : CustomFont.blackMedBold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NotifikasiPage()),
                  // );
                },
                child: Row(
                  children: [
                    Icon(
                      const IconData(58447, fontFamily: 'MaterialIcons'),
                      color: CustomColor.theme,
                      size : 28,
                    ),

                    SizedBox(width: 20),
                    Expanded(child: Text('Notifikasi', style : CustomFont.blackMedBold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UpdatePassword()),
                  // );
                },
                child: Row(
                  children: [
                    Icon(
                      const IconData(58751, fontFamily: 'MaterialIcons'),
                      color: CustomColor.theme,
                      size : 28,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Ubah Password', style : CustomFont.blackMedBold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FAQPage()),
                  // );
                },
                child: Row(
                  children: [
                    Icon(
                      const IconData(58122, fontFamily: 'MaterialIcons'),
                      color: CustomColor.theme,
                      size : 28,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text('Bantuan', style : CustomFont.blackMedBold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 20),
              child: GestureDetector(
                onTap: (){

                },
                child: Row(
                  children: [
                    Icon(
                      const IconData(58291, fontFamily: 'MaterialIcons'),
                      color: CustomColor.theme,
                      size : 28,
                    ),

                    SizedBox(width: 20),
                    Expanded(child: Text('Log Out', style : CustomFont.blackMedBold)),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavbar(current: 3),
    );
  }
}
