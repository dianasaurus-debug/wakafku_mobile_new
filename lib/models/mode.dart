import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Mode {
  final String label;
  final String name;
  final IconData icon;
  final TravelMode travel_mode;

  Mode({
    required this.name,
    required this.label,
    required this.icon,
    required this.travel_mode
  });

  factory Mode.fromJson(Map<String, dynamic> json) {
    return Mode(
      label: json['label'],
      name: json['name'],
      icon: json['icon'],
      travel_mode : json['travel_mode']
    );
  }
}