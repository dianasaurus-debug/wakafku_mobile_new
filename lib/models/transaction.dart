
class Transaction {
  String? paymentCode;
  String? message;
  String? amount;
  String? paidAt;
  String? paymentMethod;
  int? status;
  String? jenisWakaf;
  String? atasNama;

  Transaction(
      {this.paymentCode,
        this.message,
        this.amount,
        this.paidAt,
        this.paymentMethod,
        this.status,
        this.jenisWakaf,
        this.atasNama});

  Transaction.fromJson(Map<String, dynamic> json) {
    paymentCode = json['payment_code'];
    message = json['message'];
    amount = json['amount'];
    paidAt = json['paid_at'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    jenisWakaf = json['jenis_wakaf'];
    atasNama = json['atas_nama'];
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