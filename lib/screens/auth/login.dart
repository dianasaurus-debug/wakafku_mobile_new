import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:final_project_mobile/mixins/dialog_mixin.dart';
import 'package:final_project_mobile/screens/auth/input_otp.dart';
import 'package:final_project_mobile/screens/auth/register.dart';
import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/network.dart';
import 'package:final_project_mobile/view_models/auth_vm.dart';
import 'package:final_project_mobile/widgets/auth_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';



class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with DialogMixin  {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String email = '';
  String password = '';
  String emailError = '';
  String fcm_token = '';
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;

    emailController = TextEditingController();
    passwordController = TextEditingController();

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Get.to(const Notification());
    });

    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      context
          .read<AuthViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      final AuthViewModel svm = context.read<AuthViewModel>();
      messaging.getToken().then((value) {
        svm.setFCMToken(value);
        print('token : ${value}');
      });
      emailController.text = svm.email;
      passwordController.text = '';
      svm.password = '';
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AuthAppBar(appBar: AppBar(), title : ''),
        body: Consumer<AuthViewModel>(
            builder: (_, AuthViewModel vm, __) => Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>
                        [
                          // SizedBox(
                          //   width: (280 / 375) * MediaQuery.of(context).size.width,
                          //   child: AspectRatio(
                          //     aspectRatio: 1.5,
                          //     child: Image.asset('images/signin.png'),
                          //   ),
                          // ),
                          // const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Silahkan login terlebih dahulu untuk mengakses semua fitur',
                                textAlign: TextAlign.left,
                                style: CustomFont.orangeMedBold
                            ),
                          ),
                          SizedBox(height : 15),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'E-Mail tidak boleh kosong';
                                    }
                                    email = value;

                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      suffixIcon: InkWell(
                                          child: Icon(Icons.clear, size: 14), onTap: () {
                                        email = '';
                                      }),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red, width: 2),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red, width: 2),
                                      ),
                                      hintText: 'E-Mail',
                                      hintStyle: CustomFont.blackMedLight,
                                      isDense: true
                                  ),
                                  controller: emailController,
                                  onChanged: vm.onEmailChange,
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password tidak boleh kosong';
                                    }
                                    password = value;
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: InkWell(
                                          child: Icon(Icons.clear, size: 14), onTap: () {
                                        password = '';
                                      }),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red, width: 2),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red, width: 2),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: CustomFont.blackMedLight,
                                      isDense: true
                                  ),
                                  controller: passwordController,
                                  onChanged: vm.onPasswordChange,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: CustomButton.buttonSubmit,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (vm.isLoading != true) {
                                        vm.validateToken().then((value) {
                                          if (vm.isLoggedIn == true) {
                                            Get.offAll(HomePage());
                                          } else {
                                            if(vm.isVerified){
                                              showFailedDialog(
                                                context: context,
                                                title: vm.message!,
                                              );
                                            } else {
                                              showSingleActionDialog(
                                                'Verifikasi E-Mail',
                                                vm.message ?? 'Loading...',
                                                'Masukkan OTP',
                                                    () => Get.offAll(InputOtpEmail()),
                                              );
                                            }
                                          }
                                        });
                                      } else {
                                        null;
                                      }
                                    }
                                  },
                                  child: Text(
                                      vm.isLoading? 'Memuat...' : 'Login',
                                      style : TextStyle(fontSize : 16)),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Belum punya akun? ',
                              style: CustomFont.blackMedLight,
                              children: <TextSpan>[
                                TextSpan(text: 'Daftar sekarang',
                                  style: CustomFont.orangeMedBold,
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterPage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                        ]
                    )
                )
            )));
  }

}
