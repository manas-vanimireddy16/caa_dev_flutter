import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';

/// Shared search field styling for My Requests / Action Items lists.
abstract final class RequestListSearchStyles {
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color borderColor = Color(0xFFD8D8D8);

  static TextStyle textStyle() => AppTextStyles.requestListSearchText();

  static InputDecoration decoration({
    required String hintText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      prefixIcon:
          prefixIcon ??
          const Icon(Icons.search, color: AppColors.searchTextColor),
      filled: true,
      fillColor: backgroundColor,
      hintText: hintText,
      hintStyle: textStyle(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
    );
  }
}
