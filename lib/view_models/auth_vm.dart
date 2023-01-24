
import 'package:final_project_mobile/models/google_user.dart';
import 'package:final_project_mobile/screens/auth/register.dart';

import '../screens/home/beranda.dart';
import '../screens/welcome/splash_screen.dart';
import '../utils/mixins/dialog_mixin.dart';
import '../utils/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:final_project_mobile/models/user.dart';
import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';

class AuthViewModel extends ChangeNotifier with DialogMixin {
  late BaseNetwork _net;
  bool isLoading = false;
  String? message;
  bool is_after_login = false;
  String email = '';
  String password = '';
  String username = '';
  String nama_lengkap = '';
  String gender = '';
  String phone = '';
  String googleToken = '';
  bool? isLoggedIn;
  bool? isFirstLogin;
  String fcm_token = '';
  int user_id = 0;
  String c_password = '';
  String name = '';
  String otp_code = '';
  bool isSuccess = false;
  bool isVerified = false;
  late DateTime birthdate;

  final emailCharacters = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  List<User> users = <User>[];
  bool isHidePassword = true;
  User? currentUser;

  late User user;
  User get userProfile => user;

  void setNetworkService(BaseNetwork net) {
    _net = net;
  }

  void togglePasswordVisibility() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  void setFCMToken(val) {
    fcm_token = val;
    notifyListeners();
  }

  void onUsernameChange(String val) {
    username = val;
    notifyListeners();
  }

  void onEmailChange(String val) {
    email = val;
  }
  void onLoadingChange(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void onPasswordChange(String val) {
    password = val;
  }

  void onConfirmationPasswordChange(String val) {
    c_password = val;
  }
  void onPhoneChange(String val) {
    phone = val;
    notifyListeners();
    print(val);
  }

  void onBirthdateChange(DateTime val) {
    birthdate = val;
    notifyListeners();
    print(val);
  }

  void onOtpChange(String val) {
    otp_code = val;
    notifyListeners();
    print(val);
  }

  void onUsernameProfileChange(String val) {
    if (val == null) {
      username = null!;
    } else {
      username = val;
    }
    notifyListeners();
  }

  void onNameProfileChange(String val) {
    if (val == null) {
      name = null!;
    } else {
      name = val;
    }
    notifyListeners();
  }

  void onGenderProfileChange(String val) {
    if (val == null) {
      gender = null!;
    } else {
      gender = val;
    }
    notifyListeners();
  }

  void onEditProfileChange(
      dynamic val,
      ) async {
    user = val;
    Get.toNamed<void>('/edit_profile');
    notifyListeners();
  }

  Future<void> validateToken() async {
    isLoading = true;
    final Response<dynamic> resp = await _net.request(
      '/login',
      requestMethod: 'post',
      data: <String, dynamic>{
        'fcm_token': fcm_token,
        'email': email,
        'password': password,
      },
      queryParameter: {},
    );

    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
    isLoading = false;
    if (respData['success'] == true) {
      if (respData['data'] != null) {
        String token = respData['access_token'];
        debugPrint('TOKEN : ' + token);
          if (token.isNotEmpty) {
            _net.setToken(token);
            _net.getToken();
          }
          isLoggedIn = true;
        isVerified = true;
      }else{
        isVerified = true;
        isLoggedIn = false;
        message = respData['message'];
      }
    } else {
      isLoggedIn = false;
      isLoading = false;

      if(respData['is_verified']==false&&respData['user']!=null){
        currentUser = User.fromJson(respData['user']);
        isLoggedIn = false;
        isVerified = false;
      } else {
        isLoggedIn = false;
        isVerified = true;
      }
      message = respData['message'];
    }
  }

  Future<void> fetchUser() async {
    isLoading = true;
    if (await _net.validateToken() == true) {
      _net.getToken();
      final Response<dynamic>? resp =
      await _net.request('/profile', queryParameter: {});
      final Map<String, dynamic> respData = resp!.data as Map<String, dynamic>;
      isLoading = false;
      print(resp!.data);
      if (respData['success'] == true) {
        isLoggedIn = true;
        currentUser = User.fromJson(respData['data']);
      } else {
        isLoggedIn = false;
        isLoading = false;
      }
    } else {

      isLoading = false;
      isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    if (await _net.validateToken() == true) {
      _net.getToken();
      final Response<dynamic> resp =
      await _net.request('/logout', queryParameter: {});
      final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
      if (respData['success'] == true) {
        isLoggedIn = false;
        Get.offAll(SplashScreenPage());
      } else {
        isLoggedIn = true;
        showErrorSnackbar('Terjadi kesalahan!');
      }
    } else {
      showSingleActionDialog(
        'Oops! Sesi telah habis!',
        'Unauthenticated!',
        'Ok',
            () => Get.offNamed<void>('/login'),
      );
    }
    notifyListeners();
  }

  Future<void> socialLogin(jenis, user_data) async {
    isLoading = true;
    final Response<dynamic> resp = await _net.request(
      '/auth/login/google',
      requestMethod: 'post',
      data: <String, dynamic>{
        'fcm_token': fcm_token,
        'token': googleToken,
        'jenis': jenis,
        'user_data': user_data
      },
      queryParameter: {},
    );
    print(resp.data);
    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
    isLoading = false;
    if (respData['success'] == true) {
      if (respData['registered'] == true) {
        if (respData['is_verified'] == false) {
          isLoggedIn = false;
          Get.toNamed<void>('/metode-otp', arguments: respData['user']["id"]);
          showSuccessSnackbar('Mohon verifikasi akun Anda terlebih dahulu');
        } else {
          String token = respData['token'];
          print('token : ' + token);
          if (token != null) {
            _net.setToken(token);
          }
          if (await _net.validateToken()) {
            _net.getToken();
          }
          isLoggedIn = true;
          notifyListeners();
          Get.offAll(HomePage());
        }
      } else {
        if (jenis == 'fb') {
          email = user_data['email'];
          nama_lengkap = user_data['name'];
        } else {
          email = user_data.email;
          nama_lengkap = user_data.displayName;
        }
        notifyListeners();
        Get.toNamed<void>('/register-sosmed');
      }
    } else {
      isLoggedIn = false;
      showSingleWarningDialog(respData['message']);
    }
  }

  //Facebook SignIn Process
  void facebookSignInProcess() async {
    LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      AccessToken accessToken = result.accessToken!;
      Map<String, dynamic> userData = await FacebookAuth.i.getUserData(
        fields: "name,email,picture.width(200),birthday,friends,gender,link",
      );
      socialLogin('fb', userData);
      print("${accessToken.userId}");
      print("$userData");
    } else {}
  }

  //Google SignIn Process
  void googleSignInProcess() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    String? token = googleAuth?.idToken;
    print('TOKEN: $token');
    if (token != null) {
      GoogleUser _socialGoogleUser = GoogleUser(
          displayName: googleUser?.displayName,
          email: googleUser?.email,
          photoUrl: googleUser?.photoUrl,
          id: googleUser?.id,
          token: token);
      googleToken = token;
      socialLogin('google', _socialGoogleUser);
      print("${_socialGoogleUser.toJson()}");
    } else {
      showSingleWarningDialog('Gagal!');
    }
  }
  Future<void> signUpRequest() async {
    isLoading = true;

    final Response<dynamic> resp = await _net.request(
      '/register',
      requestMethod: 'post',
      data: <String, dynamic>{
        'email': email,
        'name': name,
        'password': password,
      },
      queryParameter: {},
    );
    print(resp.data);
    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
    if (respData['success'] == true) {
      currentUser = User.fromJson(respData['user']);
      isSuccess = true;
      isVerified = false;
      isLoggedIn = false;
      isLoading = false;
      message = respData['message'];
    } else {
      isSuccess = false;
      isLoggedIn = false;
      isLoading = false;
      if(respData['is_verified']==false){
        isLoggedIn = false;
        isVerified = false;
      } else {
        isLoggedIn = false;
        isVerified = true;
      }
      message = respData['message'];
    }

  }

  Future<void> sendOtp() async {
    isLoading = true;
    final Response<dynamic> resp = await _net.request(
      '/auth/otp/send',
      requestMethod: 'put',
      data: <String, dynamic>{
        'id_user': user_id,
        'jenis': 'email',
      },
      queryParameter: {},
    );
    print(resp.data);

    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;

    if (respData['success'] != false) {
      isLoading = false;
      Get.toNamed<void>('/input-otp-email');
      showSuccessSnackbar('Sukses mengirim OTP ke ${email}!');
    } else {
      isLoading = false;
      showSingleWarningDialog('Terdapat kesalahan!');
    }
  }

  Future<void> verificationOtp() async {
    isLoading = true;
    final Response<dynamic> resp = await _net.request(
      '/verify/otp',
      requestMethod: 'put',
      data: <String, dynamic>{'kode_otp': otp_code},
      queryParameter: {},
    );
    print(resp.data);

    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
    isLoading = false;

    if (respData['success'] != false) {
      isSuccess = true;
      if (respData['is_verified'] != false) {
        isLoading = false;
        Get.offNamedUntil('/login', (route) => route.isFirst);
        isVerified = true;
      }
    } else {
      isSuccess = false;
      isLoading = false;
      isVerified = false;

      showErrorSnackbar(respData['message']);
    }
  }

  Future<void> checkEmail({required String email}) async {
    isLoading = true;
    final Response<dynamic> resp =
    await _net.request('/auth/check-email/$email', queryParameter: {});
    print(resp.data);
    final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;

    if (respData['data'] != null) {
      if (respData['data']['is_verified'] == null) {
        isLoading = false;
        isVerified = false;
        print('yes');
        Get.toNamed<void>('/metode-otp', arguments: respData['data']["id"]);
        showSuccessSnackbar('Mohon verifikasi akun Anda terlebih dahulu');
      }else{
        isLoading = false;
        isVerified = true;
        message = respData['message'];
      }
    } else {
      isLoading = false;
      isVerified = false;
      Get.to(RegisterPage(), arguments: email);
    }
  }



}
