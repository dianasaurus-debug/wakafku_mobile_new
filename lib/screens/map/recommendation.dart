import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:final_project_mobile/models/instruction.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/map/list_programs.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:provider/provider.dart';

import '../../mixins/dialog_mixin.dart';
import '../../utils/constants.dart';
import '../../utils/network.dart';
import '../../view_models/auth_vm.dart';
import '../../view_models/program_vm.dart';

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage>
    with DialogMixin {
  final Map<String, Marker> _markers = {};
  List<Program> program_markers = [];
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  bool isNavigating = false;
  bool isInstructionOpened = false;

  late LatLng myPosition;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  bool isListShown = true;
  LocationManager.Location location = new LocationManager.Location();
  double _lat = -7.317463;
  double _lng = 111.761466;
  late CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 16,
  );
  Completer<GoogleMapController> _controller = Completer();
  var mapController;

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
    final ProgramViewModel svm = context.read<ProgramViewModel>();
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      controller.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(res.latitude!, res.longitude!), 16));
      svm.setCoordinates(res.latitude!.toString(), res.longitude!.toString());
      print(
          "Koordinat exact : ${res.latitude!.toString()}, ${res.longitude!.toString()}");
      setState(() {
        _currentPosition = CameraPosition(
          target: LatLng(res.latitude!, res.longitude!),
          zoom: 16,
        );
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
  }

  void getRoute(ProgramViewModel program_vm, kendaraan, latakhir, longakhir) async {
    if (latakhir == '' && longakhir == '') {
      latakhir = program_vm.latakhir_route;
      longakhir = program_vm.lonakhir_route;
    }
    final GoogleMapController controller = await _controller.future;

    final _position = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 16,
    );
    program_vm.setKendaraan(kendaraan);
    program_vm.setStartCoordinates(_lat.toString(), _lng.toString());
    program_vm.setEndCoordinates(latakhir, longakhir);
    program_vm.fetchRoutes().then((value) {
      if (program_vm.points.length > 0) {
        final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
        _polylineIdCounter++;
        final PolylineId polylineId = PolylineId(polylineIdVal);
        final Polyline polyline = Polyline(
          polylineId: polylineId,
          consumeTapEvents: true,
          color: Colors.green,
          width: 4,
          points: program_vm.points,
        );
        setState(() {
          _mapPolylines[polylineId] = polyline;
        });
        controller.animateCamera(CameraUpdate.newCameraPosition(_position));
        if (isNavigating == false) {
          Navigator.pop(context);
        }
        setState(() {
          isNavigating = true;
        });
      } else {
        setState(() {
          isNavigating = false;
        });
        Navigator.pop(context);

        showErrorSnackbar('Terdapat kesalahan!');
      }
    });
  }
  void getDirection(ProgramViewModel program_vm) async {
    final GoogleMapController controller = await _controller.future;
    final _position = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 16,
    );
    program_vm.fetchDirections().then((value) {
      if (program_vm.route_instructions.length > 0) {
        setState(() {
          isInstructionOpened = true;
        });
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Container(
                  padding: EdgeInsets.all(10),
                  height : MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Panduan Rute',
                              style: CustomFont.blackMedBold),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isInstructionOpened = false;
                              });
                              Navigator.pop(context, true);
                            },
                            child: Icon(Icons.close,
                                color: Colors.red, size: 20),
                          ),
                        ],
                      ),
                      Divider(
                        color: CustomColor.themedarker,
                      ),
                      SingleChildScrollView(
                        child : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: program_vm.route_instructions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(program_vm.route_instructions[index].icon, size : 30),
                              title: Html(data: """${program_vm.route_instructions[index].desc}"""),
                              subtitle: Text(program_vm.route_instructions[index].distance, style: CustomFont.blackTinyLight),
                            );
                          },
                          separatorBuilder: (context, position) {
                            return Divider(
                              color: CustomColor.themedarker,
                            );
                          },
                        )
                      )
                    ],
                  ),
                );
              });
            });
      }
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
    final Uint8List markerIcon = await getBytesFromAsset(
        'lib/assets/images/maps/icon-lokasi-saya.png', 80);
    final Uint8List waqfLocation = await getBytesFromAsset(
        'lib/assets/images/maps/program_marker.png', 120);
    _controller.complete(controller);
    final ProgramViewModel svm = context.read<ProgramViewModel>();
    context.read<ProgramViewModel>().fetchAllPrograms().then((value) {
      setState(() {
        _markers.clear();
        _markers['Lokasi saya'] = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId('Lokasi saya'),
          position: LatLng(_lat, _lng),
          infoWindow: InfoWindow(
            title: 'Lokasi saya',
          ),
        );
      });
      for (Program program in svm.program_list) {
        final marker = Marker(
          markerId: MarkerId(program.id.toString()),
          icon: BitmapDescriptor.fromBytes(waqfLocation),
          position: LatLng(
              double.parse(program.latitude), double.parse(program.longitude)),
          infoWindow: InfoWindow(
            title: '${program.title}',
            snippet:
                'Jarak : ${program.distance != 0 ? program.distance.toStringAsFixed(1) : '?'} Km',
          ),
          onTap: () {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                new CameraPosition(
                    target: LatLng(double.parse(program.latitude),
                        double.parse(program.longitude)),
                    zoom: 18)));
            if (isNavigating == false) {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      child: _buildBottonNavigationMethod(program),
                    );
                  });
            } else {
              getRoute(svm, svm.jenis_kendaraan, svm.latakhir_route,
                  svm.lonakhir_route);
            }
          },
        );
        setState(() {
          _markers[program.id.toString()] = marker;
        });
      }
    });

    print('Marker!');
    print(_markers);
  }

  Widget _buildBottonNavigationMethod(Program program) {
    return Consumer<ProgramViewModel>(
        builder: (_, ProgramViewModel program_vm, __) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(program.title, style: CustomFont.blackMedBold),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(FontAwesomeIcons.mapLocation,
                          color: CustomColor.theme, size: 20),
                      SizedBox(width: 10),
                      Text(
                        '${program.address_detail}',
                        style: CustomFont.blackMedLight,
                      ),
                    ]),
                    Row(children: [
                      Icon(FontAwesomeIcons.arrowRight,
                          color: CustomColor.theme, size: 20),
                      SizedBox(width: 5),
                      Text(
                        '${program.distance.toStringAsFixed(1)} Km',
                        style: CustomFont.blackMedBold,
                      ),
                    ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terkumpul',
                      style: CustomFont.blackMedLight,
                    ),
                    Text('Rp ${program.terkumpul}',
                        style: CustomFont.blackBigBold),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${IMG_PATH}${program.cover}',
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
                SizedBox(height: 20),
                Row(children: [
                  ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rute", style: CustomFont.whiteBigBold),
                          ]),
                      style: CustomButton.buttonSubmit,
                      onPressed: () async {
                        getRoute(program_vm, program_vm.jenis_kendaraan,
                            program.latitude, program.longitude);
                      }),
                  SizedBox(width: 10),
                  ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Berwakaf", style: CustomFont.whiteBigBold),
                          ]),
                      style: CustomButton.buttonSubmit,
                      onPressed: () {})
                ])
              ],
            )));
  }

  void showListProgram() async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
            return Container(
              margin: EdgeInsets.only(right: 100),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daftar Program Wakaf Terdekat',
                          style: CustomFont.blackMedBold),
                      GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: Icon(Icons.keyboard_arrow_down,
                            color: CustomColor.theme, size: 30),
                      ),
                    ],
                  ),
                  Divider(
                    color: CustomColor.themedarker,
                  ),
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
                              Row(children: [
                                Icon(FontAwesomeIcons.locationPin,
                                    color: CustomColor.theme, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  'Jln Sudirohusodo, Malang',
                                  style: CustomFont.blackSmallight,
                                ),
                              ]),
                            ]),
                        trailing: Text('6 Km', style: CustomFont.orangeMedBold),
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
        });
  }

  void viewModel() {
    context
        .read<ProgramViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context
        .read<AuthViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context.read<AuthViewModel>().fetchUser();
  }

  @override
  void initState() {
    _locateMe();
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showListProgram();
    // });
    viewModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramViewModel>(
        builder: (_, ProgramViewModel program_vm, __) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: isNavigating == false
                    ? InkWell(
                        child: Icon(Icons.arrow_back_ios_rounded,
                            color: CustomColor.themedarker, size: 25),
                        onTap: () => Navigator.of(context).pop(),
                      )
                    : InkWell(
                        child: Icon(Icons.close,
                            color: CustomColor.themedarker, size: 25),
                        onTap: () {
                          setState(() {
                            isInstructionOpened = false;
                          });
                          setState(() {
                            isNavigating = false;
                          });
                          program_vm.clearPoint();
                          program_vm.clearInstructions();
                        },
                      ),
                toolbarHeight: 90,
                elevation: 0,
                title: isNavigating == true
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Row(children: [
                          for (var i = 0; i < modes.length; i++) ...[
                            IconButton(
                              icon: Icon(modes[i].icon,
                                  color: program_vm.jenis_kendaraan ==
                                          modes[i].label
                                      ? Colors.blueAccent
                                      : Colors.black),
                              onPressed: () {
                                program_vm.setKendaraan(modes[i].label);
                                getRoute(program_vm, modes[i].label, '', '');
                              },
                            ),
                          ]
                        ]))
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          children: [
                            Text('Program Wakaf Terdekat',
                                style: CustomFont.orangeMedBold),
                            SizedBox(height: 5),
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
                                  suffixIcon: GestureDetector(
                                    onTap: () {},
                                    child: Icon(Icons.filter_list_alt,
                                        color: CustomColor.theme),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Icon(CupertinoIcons.search,
                                        color: CustomColor.themedarkest),
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

                                Program program_selected =
                                    new Program.fromJson(suggestion_parse);
                                mapController.animateCamera(CameraUpdate
                                    .newCameraPosition(new CameraPosition(
                                        target: LatLng(
                                            double.parse(
                                                program_selected.latitude),
                                            double.parse(
                                                program_selected.longitude)),
                                        zoom: 18)));
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        child: _buildBottonNavigationMethod(
                                            program_selected),
                                      );
                                    });
                              },
                            )
                          ],
                        )),
              ),
              body: Column(
                children: [
                  if (isNavigating == false) ...[
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Peta".toUpperCase(),
                                          style: CustomFont.textInfoWhiteLight),
                                    ]),
                                style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            CustomColor.themedarker),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0)))),
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecommendationPage()))
                                    })),
                        Expanded(
                            child: ElevatedButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Daftar".toUpperCase(),
                                          style: CustomFont.textInfoWhiteLight),
                                    ]),
                                style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            CustomColor.theme),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0)))),
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListProgramPage()))
                                    })),
                      ],
                    ),
                  ],
                  Expanded(
                    child: GoogleMap(
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: _currentPosition,
                      markers: _markers.values.toSet(),
                      polylines: Set<Polyline>.of(_mapPolylines.values),
                    ),
                  )
                ],
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: isInstructionOpened == false && isNavigating == true ? FloatingActionButton.extended(
                onPressed: () {
                  getDirection(program_vm);
                },
                backgroundColor: Colors.white,
                label: Text('Instruksi', style : CustomFont.blackSmallBold),
                icon: Row(
                  children : [
                    Icon(Icons.route, color : CustomColor.theme),
                  ]
                ),
              ) : Container()
            ));
  }
}
