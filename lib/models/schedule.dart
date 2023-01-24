
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/transaction.dart';

class Schedule {
  late String notes;
  late String scheduled_date;
  late int is_activated;
  late String amount;
  PaymentMethod? paymentMethod;
  Program? program;
  Transaction? transaction;
  late int id;


  Schedule({
    this.id=0,
    this.notes="",
    this.amount = '',
    this.scheduled_date="",
    this.is_activated=0,
  });

  Schedule.fromJson(Map<String, dynamic> json)
      : notes = json['notes'],
        amount = json['amount'],
        scheduled_date = json['scheduled_date'],
        transaction = json['transaction']!=null ? new Transaction.fromJson(json['transaction']):null,
        paymentMethod = new PaymentMethod.fromJson(json['payment_method']),
        program = new Program.fromJson(json['program']),
        is_activated = int.parse(json['is_activated']),
        id = json['id'].runtimeType == String ? int.parse(json['id']) : json['id'];
  Map<String, dynamic> toJson() => {
    'id' : id,
  };
}