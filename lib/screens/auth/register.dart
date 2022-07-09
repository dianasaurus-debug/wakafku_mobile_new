import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:final_project_mobile/screens/auth/input_otp.dart';
import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/auth_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var nama_lengkap;
  var password;
  var c_password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AuthAppBar(appBar: AppBar(), title : ''),
        body: Center(
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
                            'Daftar terlebih dahulu untuk dapat login',
                            textAlign: TextAlign.left,
                            style: CustomFont.orangeMedBold
                        ),
                      ),
                      SizedBox(height : 15),
                      Padding(
                        padding : EdgeInsets.symmetric(horizontal: 20),
                        child : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children : [
                              ElevatedButton(
                                style: CustomButton.buttonSocial,
                                onPressed: () {

                                },
                                child: Row(
                                    children : [
                                      Icon(FontAwesomeIcons.facebook, color: CustomColor.theme, size: 25,),
                                      SizedBox(width: 5,),
                                      Text('Facebook', style: CustomFont.orangeMedBold,)
                                    ]
                                ),
                              ),
                              ElevatedButton(
                                style: CustomButton.buttonSocial,
                                onPressed: () {

                                },
                                child: Row(
                                    children : [
                                      Icon(FontAwesomeIcons.google, color: CustomColor.theme,size: 25,),
                                      SizedBox(width: 5,),
                                      Text('Google', style: CustomFont.orangeMedBold,)
                                    ]
                                ),
                              ),

                            ]
                        ),
                      ),
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
                                  return 'Nama Lengkap tidak boleh kosong';
                                }
                                nama_lengkap = value;

                                return null;
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.person),
                                  suffixIcon: InkWell(
                                      child: Icon(Icons.clear, size: 14), onTap: () {
                                    nama_lengkap = '';
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
                                  hintText: 'Nama Lengkap',
                                  hintStyle: CustomFont.blackMedLight,
                                  isDense: true
                              ),

                            ),
                            const SizedBox(height: 10),
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
                                  prefixIcon: Icon(CupertinoIcons.padlock),
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

                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password tidak boleh kosong';
                                } else {
                                  if(c_password!=password){
                                    return 'Konfirmasi password harus sama';
                                  } else {
                                    c_password = value;
                                  }
                                }

                                return null;
                              },
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.padlock_solid),
                                  suffixIcon: InkWell(
                                      child: Icon(Icons.clear, size: 14), onTap: ()
                                  {
                                    c_password = '';
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
                                  hintText: 'Konfirmasi Password',
                                  hintStyle: CustomFont.blackMedLight,
                                  isDense: true
                              ),

                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: CustomButton.buttonSubmit,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InputOtpEmail()),
                                );
                                // if (_formKey.currentState!.validate()) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => InputOtpEmail()),
                                //   );
                                // }
                              },
                              child: Text(
                                  _isLoading? 'Memuat...' : 'Daftar',
                                  style : TextStyle(fontSize : 16)),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style: CustomFont.blackMedLight,
                          children: <TextSpan>[
                            TextSpan(text: 'Login disini',
                              style: CustomFont.orangeMedBold,
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                    ]
                )
            )
        ));
  }
}
