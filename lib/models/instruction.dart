import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Instruction {
  final String desc;
  final String duration;
  final String distance;
  final IconData icon;

  Instruction({
    required this.desc,
    required this.duration,
    required this.icon,
    required this.distance
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
        desc: json['desc'],
        distance: json['distance'],
        icon: json['icon'],
        duration : json['duration']
    );
  }
}