import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/screens/program/categories.dart';
import 'package:final_project_mobile/screens/program/list.dart';
import 'package:final_project_mobile/screens/transaction/notification.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/utils/network.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/view_models/firebase_service.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/nav_drawer.dart';
import 'package:final_project_mobile/widgets/program_tile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;

import '../../models/program.dart';
import '../program/detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LatLng myPosition;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late FirebaseMessaging messaging;

  bool isListShown = true;
  LocationManager.Location location = new LocationManager.Location();
  double _lat = -7.317463;
  double _lng = 111.761466;
  late CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 16,
  );
  Completer<GoogleMapController> _controller = Completer();

  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
    context
        .read<AuthViewModel>().setNetworkService(context.read<BaseNetwork>());
    context.read<AuthViewModel>().fetchUser();

  }
  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == LocationManager.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != LocationManager.PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      setState(() {
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
    final ProgramViewModel svm = context.read<ProgramViewModel>();
    svm.setCoordinates(_lat.toString(), _lng.toString());
    context.read<ProgramViewModel>().fetchAllPrograms();
  }

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
        Text(event.notification!.title!, style: CustomFont.blackMedBold),
        subtitle:
        Text(event.notification!.body!, style: CustomFont.smallTheme),
        background: Colors.white,
        duration: const Duration(seconds: 20),
        elevation: 2,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(NotificationPage());
    });
    viewModel();
    _locateMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthViewModel>(
      builder: (_, AuthViewModel user_vm, __) => Consumer<ProgramViewModel>(
          builder: (_, ProgramViewModel program_vm, __) => Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: CustomColor.theme),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            elevation: 0,
            actions:  [
              if(user_vm.isLoggedIn == false)...[
                IconButton(
                    icon: Icon(CupertinoIcons.arrow_right_square_fill,
                        color: CustomColor.theme),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }),
              ]

              // IconButton(
              //   icon: Icon(CupertinoIcons.bell_fill,
              //       color: CustomColor.theme),
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(builder: (context) => LoginIndexPage()),
              //     // );
              //   }),
            ]

        ),
        body:
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(user_vm.isLoggedIn == true)...[
                          Text('Halo, ${user_vm.currentUser!.name}', style: CustomFont.orangeBigBold),
                        ] else ...[
                          Text('Halo', style: CustomFont.orangeBigBold),
                        ],
                        SizedBox(height : 8),
                        Text('Sudahkah kamu berwakaf hari ini?',
                            style: CustomFont.blackMedBold),
                      ])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                            filled: true,
                            isDense: true,
                            fillColor: CustomColor.white1,
                            prefixIcon: Padding(
                              padding:
                              EdgeInsets.only(left: 10, right: 10),
                              child: Icon(CupertinoIcons.search,
                                  color: CustomColor.themedarkest),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 25,
                              minHeight: 40,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintStyle: CustomFont.blackSmallight,
                            hintText: ' Cari Program Wakaf',
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern.length > 0) {
                            return await program_vm
                                .getProgramRecommendations(pattern);
                          } else {
                            return [];
                          }
                        },
                        itemBuilder: (context, suggestion) {
                          var suggestion_parse = (suggestion as Map);

                          return ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(suggestion!['title']),
                            subtitle: Text(
                                '${suggestion['distance'].toStringAsFixed(1)} Km'),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          var suggestion_parse =
                          (suggestion as Map<String, dynamic>);

                          Program program_selected = new Program.fromJson(suggestion_parse);
                          Route route = MaterialPageRoute(builder: (context) => ProgramDetail(program : program_selected));
                          Navigator.push(context, route);
                        },
                      )
                    ],
                  )),
              Container(
                height:170,
                width: double.infinity,
                padding: EdgeInsets.only(left : 20, right: 40),
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Susah menemukan program wakaf?',style: CustomFont.blackBigBold,),
                    SizedBox(height: 5,),
                    ElevatedButton(
                      style: CustomButton.buttonSubmit,
                      onPressed: (){

                      },
                      child: Text('Cari disini', style: CustomFont.whiteMedBold,),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    opacity: 0.6,
                    image: AssetImage("lib/assets/images/mosque_pic.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori', style: CustomFont.blackMedBold),
                    SizedBox(height : 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: categories.map((e) =>
                            GestureDetector(
                              onTap: (){
                                if(e.id==0){
                                  Route route = MaterialPageRoute(builder: (context) => IndexCategory());
                                  Navigator.push(context, route);
                                } else {
                                  Route route = MaterialPageRoute(builder: (context) => ListProgramByCategory(category: e));
                                  Navigator.push(context, route);
                                }

                              },
                              child : Container(
                                  margin: EdgeInsets.only(right: 5),
                                  width: 75,
                                  child : Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                                            color: Colors.tealAccent.withOpacity(0.3),
                                          ),
                                          width: 70,
                                          height: 60,
                                          padding: EdgeInsets.all(10),
                                          child: Icon(e.image)
                                      ),
                                      SizedBox(height: 3),
                                      Text(e.name)
                                    ],
                                  )
                              )
                            )

                          )
                              .toList())
                    ),
                  ],
                )
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Program Wakaf Terbaru', style: CustomFont.blackMedBold),
                      SizedBox(height : 15),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: program_vm.program_list.map((program) =>
                                  ProgramTile(program)).toList())
                      ),
                    ],
                  )
              )


            ],
          ),
        ),
      bottomNavigationBar: BottomNavbar(current: 0))),
    );
  }
}
