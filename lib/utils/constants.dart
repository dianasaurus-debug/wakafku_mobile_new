import 'dart:math';

import 'package:final_project_mobile/models/category.dart';
import 'package:final_project_mobile/models/program.dart';
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