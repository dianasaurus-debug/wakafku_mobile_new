import 'dart:math';
import 'dart:typed_data';

import 'package:final_project_mobile/models/category.dart';
import 'package:final_project_mobile/models/payment_instruction.dart';
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../models/mode.dart';

const domain_local = 'http://192.168.1.55:8000';
const API_URL = '${domain_local}/api';
const IMG_PATH = '${domain_local}/img/';
const BANK_LOGO_IMG_PATH = '${domain_local}/images/payment_logo/';
const GRASSHOPPER_API_URL = 'https://graphhopper.com/api/1';
const GMAP_API_URL = 'https://maps.googleapis.com/maps/api/';
const GMAP_API_KEY = 'AIzaSyCkkZkOtiJ4BYjLDShdME7R_7ECjNnid6c';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
IconData detectIcon(sign){
  IconData namaIcon  = Icons.turn_slight_left;
  switch(sign){
    case 'TURN_SLIGHT_LEFT' : namaIcon = Icons.turn_slight_left;
    break;
    case 'TURN_SHARP_LEFT' : namaIcon = Icons.turn_sharp_left;
    break;
    case 'UTURN_LEFT' : namaIcon = Icons.u_turn_left;
    break;
    case 'TURN_LEFT' : namaIcon = Icons.turn_left;
    break;
    case 'TURN_SLIGHT_RIGHT' : namaIcon = Icons.turn_slight_right;
    break;
    case 'TURN_SHARP_RIGHT' : namaIcon = Icons.turn_sharp_right;
    break;
    case 'UTURN_RIGHT' : namaIcon = Icons.u_turn_right;
    break;
    case 'TURN_RIGHT' : namaIcon = Icons.turn_right;
    break;
    case 'STRAIGHT' : namaIcon = Icons.straight;
    break;
    case 'RAMP_LEFT' : namaIcon = Icons.ramp_left;
    break;
    case 'RAMP_RIGHT' : namaIcon = Icons.ramp_right;
    break;
    case 'MERGE' : namaIcon = Icons.merge;
    break;
    case 'FORK_LEFT' : namaIcon = Icons.fork_left;
    break;
    case 'FORK_RIGHT' : namaIcon = Icons.fork_right;
    break;
    case 'FERRY' : namaIcon = Icons.directions_boat;
    break;
    case 'FERRY_TRAIN' : namaIcon = Icons.train;
    break;
    case 'ROUNDABOUT_LEFT' : namaIcon = Icons.roundabout_left;
    break;
    case 'ROUNDABOUT_RIGHT' : namaIcon = Icons.roundabout_right;
    break;
  }
  return namaIcon;

}

List<Category> categories = [
  new Category('Semua', 0, 'all', 'all.png', 'test'),
  new Category('Umum', 1, 'sosial', 'sosial.png', 'test'),
  new Category('Edukasi', 2, 'edukasi', 'edukasi.png', 'test'),
  new Category('Ekonomi', 3, 'ekonomi', 'ekonomi.png', 'test'),
  new Category('Kesehatan', 4, 'kesehatan', 'kesehatan.png', 'test'),
];
List<Mode> modes = [
  new Mode(name : 'Mobil', icon: Icons.directions_car , label: 'driving', travel_mode : TravelMode.driving),
  new Mode(name : 'Sepeda', icon: Icons.pedal_bike, label: 'bicycling', travel_mode : TravelMode.bicycling),
  new Mode(name : 'Sepeda Motor', icon: Icons.motorcycle, label: 'MOTORCYCLE', travel_mode : TravelMode.driving),
  new Mode(name : 'Jalan Kaki', icon: Icons.directions_walk, label: 'walking', travel_mode : TravelMode.walking),
];
List<Program> programs = [
  new Program(id: 1, title: 'Program Indonesia Berwakaf', address_detail: 'Jln Basuki Rahmat', latitude: '-7.191911', longitude: '111.92181', cover: 'https://paybill.id/cfd/upload/banner-program/compress/paybill-program-banner-1-EBVRED-1619193991599.png', terkumpul: '2000000'),
  new Program(id: 2, title: 'Renovasi Sekolah Luar Biasa', address_detail: 'Jln Basuki Rahmat', latitude: '-7.191911', longitude: '111.92181', cover: 'https://static.republika.co.id/uploads/images/inpicture_slide/rumah-zakat-bersama-apbi-membantu-renovasi-sekolah-di-sigi-_191109141656-194.png', terkumpul: '2000000'),
  new Program(id: 3, title: 'Musholla Untuk Warga Desa', address_detail: 'Ds Kasiman', latitude: '-7.191911', longitude: '111.92181', cover: 'https://www.niaga.asia/wp-content/uploads/2019/04/20190408_1037041.jpg', terkumpul: '2000000'),

];
List<Transaction> transactions = [
  // new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  // new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  // new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  // new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
];
List<PaymentMethod> payment_methods = [
  new PaymentMethod(name: 'Bank Mandiri', label : 'mandiri',kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/mandiri.png'),
  new PaymentMethod(name: 'Bank BNI', label : 'bni',kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bni.png'),
  new PaymentMethod(name: 'Bank BCA', label : 'bca',kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bca.png'),
  new PaymentMethod(name: 'Bank BRI', label : 'bri',kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bri.png'),
  new PaymentMethod(name: 'ShopeePay', label : 'mandiri',kind: 'E-Wallet', logo: 'lib/assets/images/payment_logo/shopeepay.png'),
  new PaymentMethod(name: 'GoPay', label : 'mandiri',kind: 'E-Wallet', logo: 'lib/assets/images/payment_logo/gopay.png'),
  new PaymentMethod(name: 'QRIS', label : 'mandiri',kind: 'QR Code', logo: 'lib/assets/images/payment_logo/qris.png'),
  new PaymentMethod(name: 'Alfamart', label : 'mandiri',kind: 'Minimarket', logo: 'lib/assets/images/payment_logo/alfamart.png'),
  new PaymentMethod(name: 'Indomaret', label : 'mandiri',kind: 'Minimarket', logo: 'lib/assets/images/payment_logo/indomaret.png'),
];
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

List<PaymentInstruction> payment_instructions = [
  new PaymentInstruction(title: 'ATM Mandiri',
      desc: '1. Masukkan kartu ATM dan Pin ATM.\n2. Pilih menu Bayar/Beli.\n3. Pilih opsi Lainnya > Multipayment.\n4. Masukkan kode biller perusahaan (biasanya sudah tercantum di instruksi pembayaran).\n5. Masukkan nomor Virtual account > Benar.\n6. Masukkan angka yang diminta untuk memilih tagihan > Ya.\n7. Layar akan menampilkan konfirmasi. Jika sesuai, pilih Ya.\n8. Selesai.'),
  new PaymentInstruction(title: 'M-Banking',
      desc: '1. Buka aplikasi M-Banking.\n2. Pilih menu Bayar/Beli.\n3. Pilih opsi Lainnya > Multipayment.\n4. Masukkan kode biller perusahaan (biasanya sudah tercantum di instruksi pembayaran).\n5. Masukkan nomor Virtual account > Benar.\n6. Masukkan angka yang diminta untuk memilih tagihan > Ya.\n7. Layar akan menampilkan konfirmasi. Jika sesuai, pilih Ya.\n8. Selesai.'),
];
String textSample='Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ';