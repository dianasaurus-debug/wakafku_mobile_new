import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/report_widget.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/program.dart';
import '../../utils/constants.dart';
import '../../utils/network.dart';
import '../../widgets/loading_screen.dart';

class ProgramReport extends StatefulWidget {
  final Program program;

  const ProgramReport(
      {Key? key,
        required this.program
      })
      : super(key: key);
  @override
  _ProgramReportState createState() => _ProgramReportState();
}

class _ProgramReportState extends State<ProgramReport> {
  @override
  void initState() {
    super.initState();
    super.initState();
    context
        .read<ProgramViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchAllReports(widget.program.id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: CustomColor.themedarker, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0),
      body: Consumer<ProgramViewModel>(
        builder: (_, ProgramViewModel vm, __) {
          if (vm.isLoading) {
            return LoadingScreen();
          } else {
            if (vm.all_reports.isEmpty) {
              return const Center(
                child: Text('Laporan Program Kosong',
                    style: CustomFont.smallTheme),
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: vm.all_reports.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ReportTile(vm.all_reports[index]);
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
