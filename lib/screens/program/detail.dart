import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/mixins/dialog_mixin.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:final_project_mobile/utils/network.dart';


import '../../utils/constants.dart';
import '../../view_models/auth_vm.dart';

class ProgramDetail extends StatefulWidget {
  final Program program;

  const ProgramDetail(
      {Key? key,
        required this.program
      })
      : super(key: key);
  @override
  _ProgramDetailState createState() => _ProgramDetailState();
}

class _ProgramDetailState extends State<ProgramDetail> with DialogMixin {
  bool isDescExpanded = false;

  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchAllPrograms();
    context.read<AuthViewModel>().fetchUser();

  }

  @override
  void initState() {
    viewModel();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthViewModel>(
        builder: (_, AuthViewModel user_vm, __) => Consumer<ProgramViewModel>(
      builder: (_, ProgramViewModel program_vm, __) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: CustomColor.themedarker, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.bookmark,
                  color: CustomColor.themedarker, size: 25),
              onTap: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: Icon(Icons.share, color: CustomColor.themedarker, size: 25),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          elevation: 0),
      body:

      SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.white],
                          ).createShader(Rect.fromLTRB(
                              0, -120, rect.width, rect.height - 15));
                        },
                        blendMode: BlendMode.darken,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  '${IMG_PATH}${widget.program.cover}',
                                )),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.redAccent,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Icon(Icons.timelapse, color: CustomColor.whitebg),
                            SizedBox(width: 3),
                            Text(
                              '3 Hari yang lalu',
                              style: CustomFont.whiteMedBold,
                            )
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.program.title}',
                    style: CustomFont.blackBigBold,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(FontAwesomeIcons.mapLocation,
                              color: CustomColor.theme, size: 20),
                          SizedBox(width: 10),
                          Text(
                            '${widget.program.address_detail}',
                            style: CustomFont.blackMedLight,
                          ),
                        ]),
                        Row(children: [
                          Icon(FontAwesomeIcons.arrowRight,
                              color: CustomColor.theme, size: 20),
                          SizedBox(width: 5),
                          Text(
                            '${widget.program.distance.toStringAsFixed(1)} Km',
                            style: CustomFont.blackMedBold,
                          ),
                        ]),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children :[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Terkumpul',
                                style: CustomFont.blackMedLight,
                              ),
                              Text('Rp ${widget.program.terkumpul}', style: CustomFont.blackBigBold),

                            ],
                          ),
                          ElevatedButton.icon(
                            icon: Icon(
                              FontAwesomeIcons.listCheck,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            label:
                            Text('Laporan', style: CustomFont.whiteSmallBold),
                            onPressed: () {
                              print('Button Pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              onPrimary: CustomColor.themedarker,
                              primary: CustomColor.theme,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                            ),
                          )

                        ]
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          ClipOval(
                            child: Material(
                                color: Colors.grey.withOpacity(0.3),
                                // Button color
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.person,
                                      color: CustomColor.themedarker,
                                    ))),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '120+',
                            style: CustomFont.blackMedBold,
                          ),
                          Text(
                            ' Wakif Mendonasikan',
                            style: CustomFont.blackMedLight,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      color: CustomColor.lightgrey,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dibuat Oleh', style: CustomFont.blackMedBold),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('lib/assets/images/sample_pic.jpg')),
                        SizedBox(width: 10),
                        Text('Al-Hikmah\nTuban',
                            style: CustomFont.blackMedLight)
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deskripsi', style: CustomFont.orangeMedBold),
                      SizedBox(height: 10),
                  Html(data: """${widget.program.desc}"""),
                    ],
                  ),
                ),
              ])),

      floatingActionButton: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Berwakaf", style: CustomFont.whiteBigBold),
                            ]),
                        style: CustomButton.buttonSubmit,
                        onPressed: () {
                          if(user_vm.isLoggedIn==true){
                            program_vm.setProgram(widget.program);
                            Route route = MaterialPageRoute(
                                builder: (context) => DetailForm());
                            Navigator.push(context, route);
                          } else {
                            user_vm.onLoadingChange(false);
                            showSingleActionDialog(
                              'Oops!',
                              'Mohon login terlebih dahulu',
                              'Login',
                                  () => Get.offAll(LoginPage()),
                            );
                          }

                        })),
                SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Navigasi", style: CustomFont.whiteBigBold),
                            ]),
                        style: CustomButton.buttonSubmit,
                        onPressed: () => {}))
              ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavbar(current: 3),
    )));
  }
}
