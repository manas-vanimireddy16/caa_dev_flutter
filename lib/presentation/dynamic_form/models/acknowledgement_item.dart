import 'package:flutter/material.dart';

class AcknowledgementItem {
  final String id;
  final String text;
  final bool isRequired;
  final bool hasAction;
  final Future<bool?> Function(BuildContext context)? onTap;

  bool isChecked;

  AcknowledgementItem({
    required this.id,
    required this.text,
    this.isRequired = true,
    this.hasAction = false,
    this.onTap,
    this.isChecked = false,
  });
}
