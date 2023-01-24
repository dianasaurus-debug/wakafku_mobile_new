
import 'dart:convert';


import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/schedule.dart';

import '../models/notification.dart';
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


class PaymentViewModel extends ChangeNotifier with DialogMixin {
  late BaseNetwork _net;
  bool isLoading = false;
  Transaction? currentTransaction;
  Schedule? currentReminder;
  bool isSuccess = false;
  var scheduled_date;
  var scheduled_amount;
  Program? scheduled_program;
  PaymentMethod? scheduled_payment_method;

  
  List<Transaction> all_payments = [];
  List<Schedule> all_reminders = [];
  List<PaymentMethod> all_payment_methods = [];


  List<NotificationModel> all_notifications = [];


  void setNetworkService(BaseNetwork net) {
    _net = net;
  }
  void setReminder(Schedule schedule) {
    currentReminder = schedule;
    notifyListeners();
  }
  void setDate(String val) {
    scheduled_date = val;
    notifyListeners();
  }
  void setAmount(String val) {
    scheduled_amount = val;
    notifyListeners();
  }
  void setProgram(Program val) {
    scheduled_program = val;
    notifyListeners();
  }
  void setPaymentMethod(PaymentMethod? val) {
    scheduled_payment_method = val;
    notifyListeners();
  }

  Future<void> fetchAllPayments() async {
    isLoading = true;
    Response<dynamic>? resp;

    resp = await _net.request('/transactions/all', queryParameter: {});

    if (resp != null) {
      all_payments.clear();
      List<dynamic> listData = resp.data['data'];
      print(resp.data);
      if(resp.data['status']=='success'){
        showSuccessSnackbar(resp.data['message']);
        for (dynamic data in listData)
          all_payments.add(Transaction.fromJson(data));
        isLoading = false;
      } else {
        showErrorSnackbar(resp.data['message']);
        isLoading = false;
      }

    } else {
      showErrorSnackbar('Gagal mendapatkan data pembayaran');
    }
    notifyListeners();
  }
  Future<void> fetchAllReminders() async {
    isLoading = true;
    Response<dynamic>? resp;

    resp = await _net.request('/reminder/all', queryParameter: {});

    if (resp != null) {
      all_reminders.clear();
      List<dynamic> listData = resp.data['data'];
      print(resp.data);
      if(resp.data['success']==true){
        showSuccessSnackbar(resp.data['message']);
        for (dynamic data in listData)
          all_reminders.add(Schedule.fromJson(data));
        isLoading = false;
      } else {
        showErrorSnackbar(resp.data['message']);
        isLoading = false;
      }

    } else {
      showErrorSnackbar('Gagal mendapatkan data pengingat');
    }
    notifyListeners();
  }

  Future<void> fetchPaymentDetail(id) async {
    isLoading = true;
    Response<dynamic>? resp;

    resp = await _net.request('/transactions/${id}', queryParameter: {});

    if (resp != null) {
      all_payments.clear();
      var listData = resp.data['data'];
      if(resp.data['status']=='success'){
        showSuccessSnackbar(resp.data['message']);
        currentTransaction = Transaction.fromJson(listData);
        isLoading = false;
      } else {
        showErrorSnackbar(resp.data['message']);
        isLoading = false;
      }

    } else {
      showErrorSnackbar('Gagal mendapatkan data pembayaran');
    }
    notifyListeners();
  }

  Future<void> fetchAllNotifications() async {
    isLoading = true;
    Response<dynamic>? resp;

    resp = await _net.request('/notification/all', queryParameter: {});

    if (resp != null) {
      all_notifications.clear();
      List<dynamic> listData = resp.data['data'];
      print(resp.data);
      if(resp.data['status']=='success'){
        showSuccessSnackbar(resp.data['message']);
        for (dynamic data in listData)
          all_notifications.add(NotificationModel.fromJson(data));
        isLoading = false;
      } else {
        showErrorSnackbar(resp.data['message']);
        isLoading = false;
      }

    } else {
      showErrorSnackbar('Gagal mendapatkan data pembayaran');
    }
    notifyListeners();
  }

  Future<void> fetchAllPaymentMethods() async {
    isLoading = true;
    final Response<dynamic> resp =
    await _net.request('/payment-methods', queryParameter: {});
    if (resp != null) {
      all_payment_methods.clear();
      List<dynamic> listDataBank = resp.data['data']['va'];
      List<dynamic> listDataEwallet = resp.data['data']['ewallet'];
      List<dynamic> listDataRetail = resp.data['data']['retail'];

      for (dynamic data in listDataBank)
        all_payment_methods.add(PaymentMethod.fromJson(data));
      for (dynamic data in listDataEwallet)
        all_payment_methods.add(PaymentMethod.fromJson(data));
      for (dynamic data in listDataRetail)
        all_payment_methods.add(PaymentMethod.fromJson(data));
      isLoading = false;
    }
    notifyListeners();
  }




}
