import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/map/list_programs.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {

  final Map<String, Marker> _markers = {};
  late LatLng myPosition;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  bool isListShown = true;
  LocationManager.Location location = new LocationManager.Location();
  double _lat = -7.317463;
  double _lng = 111.761466;
  late CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 12,
  );
  Completer<GoogleMapController> _controller = Completer();
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
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude!, res.longitude!),
        zoom: 12,
      );
      controller.moveCamera(CameraUpdate.newLatLngZoom(LatLng(res.latitude!, res.longitude!), 12));
      //
      // controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _currentPosition = CameraPosition(
          target: LatLng(res.latitude!, res.longitude!),
          zoom: 12,
        );
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
  }
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    setState(() {
      _markers.clear();
    });
    setState(() {
      _markers['Lokasi saya'] = Marker(
        markerId: MarkerId('Lokasi saya'),
        position: LatLng(_lat, _lng),
        infoWindow: InfoWindow(
          title: 'Lokasi saya',
        ),
      );
    });

  }
  void showListProgram() async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Daftar Program Wakaf Terdekat', style: CustomFont.blackMedBold),
                          GestureDetector(
                            onTap: () => Navigator.pop(context, true),
                            child: Icon(
                                Icons.keyboard_arrow_down, color: CustomColor.theme, size: 30),
                          ),
                        ],
                      ),
                      Divider(color: CustomColor.themedarker,),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Program Wakaf Sejahtera',
                                      style: CustomFont.blackMedBold),
                                  Row(
                                      children : [
                                        Icon(FontAwesomeIcons.locationPin,
                                            color:CustomColor.theme, size: 20),
                                        SizedBox(width : 5),
                                        Text(
                                          'Jln Sudirohusodo, Malang',
                                          style: CustomFont.blackSmallight,
                                        ),
                                      ]
                                  ),

                                ]
                            ),
                            trailing: Text('6 Km',
                                style: CustomFont.orangeMedBold),

                          );
                        },
                        separatorBuilder: (context, position) {
                          return Divider(
                            color: CustomColor.themedarker,
                          );
                        },
                      )
                    ],
                  ),
                );
              });
        }
    );
  }

  @override
  void initState() {
    _locateMe();
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showListProgram();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
        AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.themedarker, size: 25),
            onTap: () => Navigator.of(context).pop(),
          ),
            toolbarHeight: 90,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Text('Program Wakaf Terdekat', style: CustomFont.orangeMedBold),
                SizedBox(height : 5),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    filled: true,
                    isDense: true,
                    fillColor: CustomColor.white1,
                    suffixIcon: GestureDetector(
                      onTap: (){

                      },
                      child :  Icon(Icons.filter_list_alt, color: CustomColor.theme),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left : 10, right: 10),
                      child: Icon(CupertinoIcons.search, color: CustomColor.themedarkest),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 25,
                      minHeight: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintStyle: CustomFont.blackSmallight,
                    hintText: ' Cari Program Wakaf',
                  ),
                )
              ],
            )
          ),
      ),
      body:
      Column(
        children: [
          Row(
            children: [
              Expanded(
                  child : ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Peta".toUpperCase(),
                                style: CustomFont.textInfoWhiteLight),
                          ]),
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(CustomColor.themedarker),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)))
                      ),
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationPage()))
                      })
              ),
              Expanded(
                  child : ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Daftar".toUpperCase(),
                                style: CustomFont.textInfoWhiteLight),
                          ]),
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColor.theme),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)))),
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListProgramPage()))

                      })
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _currentPosition,
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft : Radius.circular(15.0), topRight : Radius.circular(15.0)),
          color: CustomColor.whitebg
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daftar Program Wakaf Terdekat', style: CustomFont.blackMedBold),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isListShown = !isListShown;
                    });
                  },
                  child: Icon(isListShown== true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, color: CustomColor.theme, size: 30),
                ),
              ],
            ),
            if(isListShown==true)...[
              Divider(color: CustomColor.themedarker,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Program Wakaf Sejahtera',
                              style: CustomFont.blackMedBold),
                          Row(
                              children : [
                                Icon(FontAwesomeIcons.locationPin,
                                    color:CustomColor.theme, size: 20),
                                SizedBox(width : 5),
                                Text(
                                  'Jln Sudirohusodo, Malang',
                                  style: CustomFont.blackSmallight,
                                ),
                              ]
                          ),

                        ]
                    ),
                    trailing: Text('6 Km',
                        style: CustomFont.orangeMedBold),

                  );
                },
                separatorBuilder: (context, position) {
                  return Divider(
                    color: CustomColor.themedarker,
                  );
                },
              ),
              SizedBox(height : 2),
              Align(alignment: Alignment.center, child : Text('Lebih Banyak', style: CustomFont.orangeMedBold,))
            ]

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
