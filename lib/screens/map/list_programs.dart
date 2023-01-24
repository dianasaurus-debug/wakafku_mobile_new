import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/map/recommendation.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/utils/network.dart';
import 'package:final_project_mobile/view_models/firebase_service.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/program_tile_horizontal.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:provider/provider.dart';

class ListProgramPage extends StatefulWidget {
  @override
  _ListProgramPageState createState() => _ListProgramPageState();
}

class _ListProgramPageState extends State<ListProgramPage> {

  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchAllPrograms();

  }
  @override
  void initState() {
    viewModel();
    FirebaseService.inAppFirebaseNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ProgramViewModel>(
        builder: (_, ProgramViewModel program_vm, __) =>
      Scaffold(
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
                      return await program_vm.getProgramRecommendations(pattern);
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
                    Route route = MaterialPageRoute(builder: (context) => ProgramDetail(program : program_selected));
                    Navigator.push(context, route);
                  },
                )

              ],
            )
        ),
      ),
      body:  Column(
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
                          backgroundColor: MaterialStateProperty.all<Color>(CustomColor.theme),
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
                              CustomColor.themedarker),
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
          SizedBox(height : 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: program_vm.program_list.length,
              itemBuilder: (BuildContext context, int index) {
                return ProgramTileHorizontal(program_vm.program_list[index]);
              },
            ),
          )
        ],
      ),
    ));
  }
}
