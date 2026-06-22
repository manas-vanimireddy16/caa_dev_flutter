import 'package:flutter/material.dart';

/// Visual tokens for the AI chatbot shell.
abstract final class ChatbotTheme {
  ChatbotTheme._();

  static const primary = Color(0xFF26285F);
  static const userBubble = Color(0xFF26285F);
  static const aiBubble = Color(0xFFF3F3F6);
  static const aiBubbleText = Color(0xFF434347);
  static const headerBackground = Color(0xFF26285F);
  static const surface = Colors.white;
  static const border = Color(0xFFE6E6E6);
  static const mutedText = Color(0xFF676767);
  static const inputFill = Color(0xFFF6F6F9);
  static const backdrop = Color(0x66000000);

  static const panelRadius = 16.0;
  static const bubbleRadius = 14.0;
  static const windowHeight = 560.0;
  static const bottomNavClearance = 88.0;
  static const horizontalInset = 16.0;
  static const floatingSize = 56.0;
}
