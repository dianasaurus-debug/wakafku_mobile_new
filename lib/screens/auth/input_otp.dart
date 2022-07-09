import 'dart:async';

import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/auth_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

// import 'package:intl/intl.dart';

class InputOtpEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new InputOtpEmailState();
}

class InputOtpEmailState extends State<InputOtpEmail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String otp_code = '';
  // bool wait = false;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  late TextEditingController otpController;

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AuthAppBar(appBar: AppBar(), title : 'Masukkan OTP'),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(children: [
              Text('Kode verifikasi (OTP) telah dikirim melalui Email ke'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('nadatalita76@gmail.com', style: CustomFont.blackBigBold),
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
                        onChanged: (String? val){
                          null;
                        },
                        controller: otpController,
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    child: Text("Lanjut".toUpperCase(),
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
                      // if (vm.isLoading != true) {
                      //   vm.verificationOtp();
                      // } else {
                      //   null;
                      // }
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
                                              'Kamu akan menerima kode verivikasi (OTP) E-Mail yang dikirimkan ke ',
                                              style: TextStyle(
                                                  color: CustomColor.text,
                                                  fontSize: 16,
                                                  height: 1.2)),
                                          TextSpan(
                                              text: 'nadatalita76@gmail.com',
                                              style: TextStyle(
                                                  color: CustomColor.text,
                                                  fontSize: 16,
                                                  height: 1.2))
                                        ]),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            MaterialButton(
                                              minWidth: size.width / 4,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)),
                                              color: CustomColor.theme,
                                              onPressed: () {},
                                              child: Text("Cara Lain"),
                                            ),
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
                                              child: Text("Lanjut"),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(5))
                                      ]);
                                });
                          }),
                  ],
                ),
              ),
            ]),
          ))
    );
  }
}
