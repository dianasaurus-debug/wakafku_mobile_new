
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';

class Transaction {
  int? id;
  String? paymentCode;
  String? message;
  String? amount;
  String? paidAt;
  PaymentMethod? paymentMethod;
  Program? program;
  String? status;
  String? jenisWakaf;
  String? atasNama;
  String? createdAt;

  Transaction(
      {this.id,
        this.paymentCode,
        this.message,
        this.amount,
        this.paidAt,
        this.paymentMethod,
        this.program,
        this.status,
        this.jenisWakaf,
        this.atasNama});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentCode = json['payment_code'];
    message = json['message'];
    amount = json['amount'].toString();
    paidAt = json['paid_at'];
    paymentMethod = new PaymentMethod.fromJson(json['payment_method']);
    program = new Program.fromJson(json['program']);

    status = json['status'];
    jenisWakaf = json['jenis_wakaf'];
    atasNama = json['atas_nama'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_code'] = this.paymentCode;
    data['message'] = this.message;
    data['amount'] = this.amount;
    data['paid_at'] = this.paidAt;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['jenis_wakaf'] = this.jenisWakaf;
    data['atas_nama'] = this.atasNama;
    return data;
  }
}