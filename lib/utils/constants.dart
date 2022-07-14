import 'dart:math';

import 'package:final_project_mobile/models/category.dart';
import 'package:final_project_mobile/models/payment_instruction.dart';
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/transaction.dart';
import 'package:flutter/material.dart';

const API_URL = 'http://192.168.111.26:8000/api';
List<Category> categories = [
  new Category('Semua', 0, 'all', 'all.png', 'test'),
  new Category('Umum', 1, 'sosial', 'sosial.png', 'test'),
  new Category('Edukasi', 2, 'edukasi', 'edukasi.png', 'test'),
  new Category('Ekonomi', 3, 'ekonomi', 'ekonomi.png', 'test'),
  new Category('Kesehatan', 4, 'kesehatan', 'kesehatan.png', 'test'),
];
List<Program> programs = [
  new Program(id: 1, title: 'Program Indonesia Berwakaf', address_detail: 'Jln Basuki Rahmat', latitude: '-7.191911', longitude: '111.92181', cover: 'https://paybill.id/cfd/upload/banner-program/compress/paybill-program-banner-1-EBVRED-1619193991599.png', terkumpul: '2000000'),
  new Program(id: 2, title: 'Renovasi Sekolah Luar Biasa', address_detail: 'Jln Basuki Rahmat', latitude: '-7.191911', longitude: '111.92181', cover: 'https://static.republika.co.id/uploads/images/inpicture_slide/rumah-zakat-bersama-apbi-membantu-renovasi-sekolah-di-sigi-_191109141656-194.png', terkumpul: '2000000'),
  new Program(id: 3, title: 'Musholla Untuk Warga Desa', address_detail: 'Ds Kasiman', latitude: '-7.191911', longitude: '111.92181', cover: 'https://www.niaga.asia/wp-content/uploads/2019/04/20190408_1037041.jpg', terkumpul: '2000000'),

];
List<Transaction> transactions = [
  new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
  new Transaction(paymentCode: '8721919101811', message: 'Pembayaran Berhasil', amount: '800000', paidAt: '2022-09-21', paymentMethod: 'Bank Mandiri', status: 1, jenisWakaf: 'Abadi', atasNama: 'Diana'),
];
List<PaymentMethod> payment_methods = [
  new PaymentMethod(name: 'Bank Mandiri', kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/mandiri.png'),
  new PaymentMethod(name: 'Bank BNI', kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bni.png'),
  new PaymentMethod(name: 'Bank BCA', kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bca.png'),
  new PaymentMethod(name: 'Bank BRI', kind: 'Virtual Account', logo: 'lib/assets/images/payment_logo/bri.png'),
  new PaymentMethod(name: 'ShopeePay', kind: 'E-Wallet', logo: 'lib/assets/images/payment_logo/shopeepay.png'),
  new PaymentMethod(name: 'GoPay', kind: 'E-Wallet', logo: 'lib/assets/images/payment_logo/gopay.png'),
  new PaymentMethod(name: 'QRIS', kind: 'QR Code', logo: 'lib/assets/images/payment_logo/qris.png'),
  new PaymentMethod(name: 'Alfamart', kind: 'Minimarket', logo: 'lib/assets/images/payment_logo/alfamart.png'),
  new PaymentMethod(name: 'Indomaret', kind: 'Minimarket', logo: 'lib/assets/images/payment_logo/indomaret.png'),
];
List<PaymentInstruction> payment_instructions = [
  new PaymentInstruction(title: 'ATM Mandiri', desc: 'LANGKAH 1: TEMUKAN ATM TERDEKAT'),
  new PaymentInstruction(title: 'M-Banking (Old Livin by Mandiri)', desc: 'LANGKAH 1: MASUK KE AKUN ANDA'),
  new PaymentInstruction(title: 'M-Banking (New Livin by Mandiri)', desc: 'LANGKAH 1: MASUK KE AKUN ANDA'),


];
String textSample='Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ';