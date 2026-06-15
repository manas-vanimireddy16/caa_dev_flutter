import 'package:flutter/material.dart';

class CardAction {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  CardAction({
    required this.icon,
    required this.color,
    required this.onPressed,
  });
}
