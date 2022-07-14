import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/payment_form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexForm extends StatefulWidget {
  final int? currentStep;
  const IndexForm(
      {Key? key,
        this.currentStep, // nullable and optional
      })
      : super(key: key);
  @override
  _IndexFormState createState() => _IndexFormState();
}

class _IndexFormState extends State<IndexForm> {
  int _activeStepIndex = 0;


  @override
  void initState() {
    super.initState();
    if(widget.currentStep!=null){
      setState(() {
        _activeStepIndex = widget.currentStep!;
      });
    }
  }

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Detail'),
      content: DetailForm(),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Bayar'),
        content: PaymentForm()),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Done'),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Last Step')
              ],
            )))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SecondAppBar(appBar: AppBar(), title : 'Pembayaran'),
      body: Stepper(
        margin: EdgeInsets.zero,
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            print('Submited');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: CustomButton.buttonSubmit,
                    onPressed: details.onStepContinue,
                    child: (isLastStep)
                        ? const Text('Simpan')
                        : const Text('Lanjut'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      style: CustomButton.buttonSubmit,
                      onPressed: details.onStepCancel,
                      child: const Text('Kembali'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(current: 3),
    );
  }
}
