import 'dart:convert';

import 'package:final_project_mobile/models/google_user.dart';
import 'package:final_project_mobile/models/instruction.dart';
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/report.dart';
import 'package:final_project_mobile/screens/program/waqf_form/confirmation_form.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../models/transaction.dart';
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

class ProgramViewModel extends ChangeNotifier with DialogMixin {
  late BaseNetwork _net;
  bool isLoading = false;
  Program? currentProgram;

  String? payment_code;
  String? message;
  int? amount;
  String? payment_method;
  String? jenis_wakaf;
  String? atas_nama;
  int? jangka_waktu;
  String? bankPengembalian;
  String? nomorRekening;
  String? namaPemilikRekening;
  Transaction? currentTransaction;
  bool isSuccess = false;
  List<PaymentMethod> all_bank = [];
  List<PaymentMethod> all_ewallet = [];
  List<PaymentMethod> all_retail = [];
  List<Report> all_reports = [];
  String? currLatitude;
  String? currLongitude;
  String? latawal_route;
  String? latakhir_route;
  String? lonawal_route;
  String? lonakhir_route;
  String jenis_kendaraan = 'driving';
  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> points = <LatLng>[];
  List<Instruction> route_instructions = <Instruction>[];

  Transaction? currTransaction;

  void setNetworkService(BaseNetwork net) {
    _net = net;
  }

  void onMessageChange(String val) {
    if (val == null) {
      message = null!;
    } else {
      message = val;
    }
    notifyListeners();
  }

  void setKendaraan(String val) {
    jenis_kendaraan = val;
    notifyListeners();
  }

  void setCoordinates(String lat, String lon) {
    currLatitude = lat;
    currLongitude = lon;
    notifyListeners();
  }

  void setStartCoordinates(String lat, String lon) {
    latawal_route = lat;
    lonawal_route = lon;
    notifyListeners();
  }

  void setEndCoordinates(String lat, String lon) {
    latakhir_route = lat;
    lonakhir_route = lon;
    notifyListeners();
  }

  void onNamaRekeningChange(String val) {
    if (val == null) {
      namaPemilikRekening = null!;
    } else {
      namaPemilikRekening = val;
    }
    notifyListeners();
  }

  void onBankPengembalianChange(String val) {
    if (val == null) {
      bankPengembalian = null!;
    } else {
      bankPengembalian = val;
    }
    notifyListeners();
  }

  void onNorekChange(String val) {
    if (val == null) {
      nomorRekening = null!;
    } else {
      nomorRekening = val;
    }
    notifyListeners();
  }

  void onJangkaWaktu(String val) {
    if (val == null) {
      jangka_waktu = null!;
    } else {
      jangka_waktu = int.parse(val);
    }
    notifyListeners();
  }

  void onPaymentMethodChange(String val) {
    if (val == null) {
      payment_method = null!;
    } else {
      payment_method = val;
    }
    notifyListeners();
  }

  void onAtasNamaChange(String val) {
    if (val == null) {
      atas_nama = null!;
    } else {
      atas_nama = val;
    }
    notifyListeners();
  }

  void setProgram(program) {
    currentProgram = program;
    notifyListeners();
  }

  void setTransaction(transaction) {
    currentTransaction = transaction;
    notifyListeners();
  }

  void onAmountChange(String val) {
    if (val == null) {
      amount = null!;
    } else {
      amount = int.parse(val);
    }
    notifyListeners();
  }

  void onJenisWakafChange(String val) {
    if (val == null) {
      jenis_wakaf = null!;
    } else {
      jenis_wakaf = val;
    }
    print(jenis_wakaf);
    notifyListeners();
  }

  void clearPoint() {
    points.clear();
    notifyListeners();
  }

  void clearInstructions() {
    route_instructions.clear();
    notifyListeners();
  }

  // List<Category> category_list = [];
  List<Program> program_list = [];
  List<Program> programs_bycategory = [];

  List<PaymentMethod> payment_methods = [];

  Future<void> fetchAllPrograms() async {
    isLoading = true;
    Response<dynamic>? resp;
    print('Koordinat: ${currLatitude}');
    if (currLatitude == null && currLongitude == null) {
      resp = await _net.request('/programs', queryParameter: {});
    } else {
      resp = await _net.request(
          '/programs?latawal=${currLatitude}&longawal=${currLongitude}',
          queryParameter: {});
    }

    if (resp != null) {
      program_list.clear();
      List<dynamic> listData = resp.data['data'];
      for (dynamic data in listData) program_list.add(Program.fromJson(data));
      isLoading = false;
    } else {
      showErrorSnackbar('Gagal mendapatkan data program wakaf');
    }
    notifyListeners();
  }

  Future<void> fetchAllReports(id) async {
    isLoading = true;
    Response<dynamic>? resp;
    resp = await _net.request('/reports/${id}', queryParameter: {});

    if (resp != null) {
      all_reports.clear();
      List<dynamic> listData = resp.data['data'];
      for (dynamic data in listData) all_reports.add(Report.fromJson(data));
      isLoading = false;
    } else {
      showErrorSnackbar('Gagal mendapatkan data report');
    }
    notifyListeners();
  }

  Future<void> fetchProgramsByCategoryId(id) async {
    isLoading = true;
    Response<dynamic>? resp;
    print('Koordinat: ${currLatitude}');
    if (currLatitude == null && currLongitude == null) {
      resp = await _net.request('/programs/category/${id}', queryParameter: {});
    } else {
      resp = await _net.request(
          '/programs/category/${id}?latawal=${currLatitude}&longawal=${currLongitude}',
          queryParameter: {});
    }
    if (resp != null) {
      programs_bycategory.clear();
      List<dynamic> listData = resp.data['data'];
      for (dynamic data in listData) programs_bycategory.add(Program.fromJson(data));
      isLoading = false;
    } else {
      showErrorSnackbar('Gagal mendapatkan data program wakaf');
    }
    notifyListeners();
  }

  Future<Iterable<dynamic>> getProgramRecommendations(keyword) async {
    isLoading = true;
    Response<dynamic>? resp;
    print('Koordinat: ${currLatitude}');
    if (currLatitude == null && currLongitude == null) {
      resp = await _net
          .request('/programs?keyword=${keyword}', queryParameter: {});
    } else {
      resp = await _net.request(
          '/programs?latawal=${currLatitude}&longawal=${currLongitude}&keyword=${keyword}',
          queryParameter: {});
    }

    if (resp.statusCode == 200) {
      return resp.data['data'];
    } else {
      showErrorSnackbar('Gagal mendapatkan data program wakaf');
      throw Exception('Failed to fetch data');
    }
  }

  // Future<void> fetchRoutes() async {
  //   isLoading = true;
  //   var fullUrl = '${GRASSHOPPER_API_URL}/route?point=${latawal_route},${lonawal_route}&point=${latakhir_route},${lonakhir_route}&elevation=true&points_encoded=false&vehicle=$jenis_kendaraan&locale=in_ID&calc_points=true&key=44dcc408-6c03-4675-ac78-863c0051be57';
  //   points.clear();
  //   var resp;
  //   resp = await await http.get(
  //     Uri.parse(fullUrl),
  //   );
  //   var daftarKoordinat = json.decode(resp.body)['paths'][0]['points']['coordinates'];
  //   for(var koordinat in daftarKoordinat){
  //     points.add(LatLng(koordinat[1], koordinat[0]));
  //   }
  //
  //   notifyListeners();
  // }
  Future<void> fetchRoutes() async {
    isLoading = true;
    clearPoint();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GMAP_API_KEY,
        PointLatLng(double.parse(latawal_route!), double.parse(lonawal_route!)),
        PointLatLng(
            double.parse(latakhir_route!), double.parse(lonakhir_route!)),
        travelMode: TravelMode.driving,
        avoidTolls: jenis_kendaraan == 'MOTORCYCLE' ? true : false);

    if (result.points.length == 0) {
      showErrorSnackbar(
          'Maaf rute tidak tersedia untuk mode transportasi yang dipilih');
    } else {
      for (PointLatLng koordinat in result.points) {
        points.add(LatLng(koordinat.latitude, koordinat.longitude));
      }
    }
    print(points.length);
    notifyListeners();
  }

  Future<void> fetchDirections() async {
    isLoading = true;
    var fullUrl =
        '${GMAP_API_URL}directions/json?origin=${latawal_route}%2C${lonawal_route}&destination=${latakhir_route}%2C${lonakhir_route}&language=id&key=${GMAP_API_KEY}';
    var resp;
    resp = await await http.get(
      Uri.parse(fullUrl),
    );
    clearInstructions();
    var response_decoded = json.decode(resp.body);
    if (response_decoded['status'] == 'OK') {
      var steps = response_decoded['routes'][0]['legs'][0]['steps'];
      if (response_decoded.length > 0) {
        var i = 0;
        for (var instruction in steps) {
          if (i == 0) {
            route_instructions.add(new Instruction(
                desc: instruction['html_instructions'],
                duration: instruction['duration']['text'],
                icon: Icons.straight,
                distance: instruction['distance']['text']));
          } else {
            route_instructions.add(new Instruction(
                desc: instruction['html_instructions'],
                duration: instruction['duration']['text'],
                icon: detectIcon(instruction['maneuver']),
                distance: instruction['distance']['text']));
          }
          i++;
        }
      }
    } else {
      showErrorSnackbar('Gagal mendapatkan data');
    }
    notifyListeners();
  }

  Future<void> fetchAllBanks() async {
    isLoading = true;
    final Response<dynamic> resp =
        await _net.request('/payment-methods', queryParameter: {});
    if (resp != null) {
      all_bank.clear();
      all_ewallet.clear();
      all_retail.clear();
      List<dynamic> listDataBank = resp.data['data']['va'];
      List<dynamic> listDataEwallet = resp.data['data']['ewallet'];
      List<dynamic> listDataRetail = resp.data['data']['retail'];

      for (dynamic data in listDataBank)
        all_bank.add(PaymentMethod.fromJson(data));
      for (dynamic data in listDataEwallet)
        all_ewallet.add(PaymentMethod.fromJson(data));
      for (dynamic data in listDataRetail)
        all_retail.add(PaymentMethod.fromJson(data));
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createTransaction() async {
    isLoading = true;
    var data = {
      'nominal': amount,
      'channel': payment_method,
      'jenis': jenis_wakaf,
      'atas_nama': atas_nama,
      'program_id': currentProgram!.id
    };
    if (jenis_wakaf == 'berjangka') {
      data['account_number'] = nomorRekening;
      data['account_holder'] = namaPemilikRekening;
      data['account_bank'] = bankPengembalian;
      data['jangka_waktu'] = jangka_waktu;
    }
    final Response<dynamic> resp = await _net.request('/payment/create',
        requestMethod: 'post', data: data, queryParameter: {});
    if (resp != null) {
      var listData = resp.data['data'];
      isLoading = false;
      notifyListeners();
      if (resp.data['success'] == true) {

        isSuccess = true;
        currentTransaction = Transaction.fromJson(resp.data['data']);
        var paymentLink = resp.data['payment_link'];
        if (payment_method != 'va') {
          if (paymentLink != null) {
            launchURL(paymentLink);
          }
          // Get.to(LoadingRedirect(), arguments: [listData["id"]]);
        } else {
          Get.offAll(ConfirmationForm());
        }

      } else {
        isSuccess = false;
      }

      notifyListeners();
    }
  }
}
