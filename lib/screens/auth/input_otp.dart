import 'dart:async';

import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/network.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/widgets/auth_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../../mixins/dialog_mixin.dart';

// import 'package:intl/intl.dart';

class InputOtpEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new InputOtpEmailState();
}

class InputOtpEmailState extends State<InputOtpEmail> with DialogMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String otp_code = '';
  // bool wait = false;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<AuthViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      final AuthViewModel svm = context.read<AuthViewModel>();
    });
  }
  late TextEditingController otpController;


  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }


  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.themedarker, size: 25),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title:
        Text('Masukkan OTP', style: CustomFont.orangeBigBold),
      ),
      body:
    Consumer<AuthViewModel>(
    builder: (_, AuthViewModel vm, __) =>
    SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(children: [
              Text('Kode verifikasi (OTP) telah dikirim melalui Email ke'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(vm.currentUser!.email ?? 'Loading...', style: CustomFont.blackBigBold),
              ),
              Row(
                children: [
                  Expanded(
                      child: PinCodeTextField(
                        key: formKey,
                        cursorColor: Colors.black,
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          inactiveColor: CustomColor.mutedField,
                          inactiveFillColor: CustomColor.mutedField,
                          errorBorderColor: Colors.red,
                          borderWidth: 1,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: size.width * (1 / 7),
                          fieldWidth: size.width * (1 / 7),
                          activeFillColor: CustomColor.whitebg,
                          selectedFillColor: CustomColor.white1,
                          selectedColor: CustomColor.theme,
                          activeColor: CustomColor.theme,
                        ),
                        enableActiveFill: true,
                        onChanged: vm.onOtpChange,
                        controller: otpController,
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    child: Text(vm.isLoading? 'Memuat...' : 'Verifikasi',
                        style: CustomFont.textInfoWhiteLight),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            CustomColor.theme),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColor.theme),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                BorderSide(color: CustomColor.theme)))),
                    onPressed: () {
                      if (vm.isLoading != true) {
                        vm.verificationOtp().then((value) {
                          if(vm.isSuccess==true){
                            Get.offAll(LoginPage());
                          } else {
                            showErrorSnackbar('Kode OTP Salah!');
                          }
                        });
                      } else {
                        null;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text:
                        'Tidak menerima kode verifikasi (OTP) ? ',
                        style: CustomFont.blackMedLight),
                    TextSpan(
                        text: ' kirim ulang ',
                        style: CustomFont.orangeMedBold,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      backgroundColor: CustomColor.whitebg,
                                      title: Text(
                                        'Konfirmasi',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                              'Anda akan menerima kode verivikasi (OTP) E-Mail yang dikirimkan ke ',
                                              style: TextStyle(
                                                  color: CustomColor.text,
                                                  fontSize: 16,
                                                  height: 1.2)),
                                          TextSpan(
                                              text: vm.currentUser!.email ?? 'Loading...',
                                              style: TextStyle(
                                                  color: CustomColor.text,
                                                  fontSize: 16,
                                                  height: 1.2))
                                        ]),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          minWidth: size.width / 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0)),
                                          color: CustomColor.theme,
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(
                                                  context, true);
                                              otpController.clear();
                                              // vm.sendOtp();
                                            });
                                          },
                                          child: Text(vm.isLoading? 'Memuat...' : 'Verifikasi'),
                                        ),
                                      ]);
                                });
                          }),
                  ],
                ),
              ),
            ]),
          )))
    );
  }
}
