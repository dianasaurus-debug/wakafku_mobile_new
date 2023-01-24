import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/models/category.dart';
import 'package:final_project_mobile/screens/map/recommendation.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:provider/provider.dart';

class ListProgramByCategory extends StatefulWidget {
  final Category category;

  const ListProgramByCategory(
      {Key? key,
        required this.category
      })
      : super(key: key);
  @override
  @override
  _ListProgramByCategoryState createState() => _ListProgramByCategoryState();
}

class _ListProgramByCategoryState extends State<ListProgramByCategory> {

  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchProgramsByCategoryId(widget.category.id);

  }
  @override
  void initState() {
    viewModel();
    FirebaseService.inAppFirebaseNotif();
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
        title: Text('Kategori ${widget.category.name}', style: CustomFont.blackMedBold),
      ),
      body: Consumer<ProgramViewModel>(
          builder: (_, ProgramViewModel program_vm, __) =>
              Column(
            children: [
              if(program_vm.programs_bycategory.length>0)...[
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: program_vm.programs_bycategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProgramTileHorizontal(program_vm.programs_bycategory[index]);
                    },
                  ),
                )
              ] else ...[
                Align(
                  alignment: Alignment.center,
                  child: Text('Tidak ada program wakaf tersedia', style: CustomFont.blackMedBold,)
                )
              ]

            ],
          )),
    );
  }
}
