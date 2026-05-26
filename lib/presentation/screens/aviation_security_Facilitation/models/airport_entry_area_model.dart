import 'package:flutter/material.dart';

class AirportPermitAreaModel {
  final String code;
  final String permit;
  final Color color;
  bool isSelected;
  String text;

  AirportPermitAreaModel({
    required this.code,
    required this.permit,
    required this.color,
    this.isSelected = false,
    this.text = '',
  });

  Map<String, dynamic> toJson() {
    return {"permit": permit, "text": text};
  }
}
