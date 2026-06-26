import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable Cairo typography helpers for the app.
abstract final class AppTextStyles {
  static TextStyle cairo({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.cairo(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      fontStyle: fontStyle,
    );
  }

  /// Applies the Cairo font family to an existing [TextStyle].
  static TextStyle from(TextStyle style) {
    return GoogleFonts.cairo(textStyle: style);
  }

  /// Request card field label (Employee Name, Status, etc.)
  static TextStyle requestCardFieldHeading({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: AppColors.grey50,
    );
  }

  /// Request card field value.
  static TextStyle requestCardFieldContent({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
      height: 16 / 14,
    );
  }

  /// Request details section title (Status Information, Employee Information, etc.)
  static TextStyle requestDetailsSectionHeading({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w700,
      color: AppColors.textHeading,
      height: 20 / 14,
    );
  }

  /// Request details field label.
  static TextStyle requestDetailsFieldHeading({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: AppColors.grey50,
      height: 16 / 12,
    );
  }

  /// Request details field value.
  static TextStyle requestDetailsFieldContent({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: AppColors.darkPrimaryTextColor,
      height: 1.66,
    );
  }

  /// Request details tab label.
  static TextStyle requestTabLabel({
    required bool isSelected,
    double? fontSize,
  }) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w500,
      color: isSelected ? AppColors.loginText : AppColors.secondaryText,
    );
  }

  /// Request Status Breakdown card title.
  static TextStyle requestStatusBreakdownTitle({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w700,
      color: AppColors.textHeading,
      height: 24 / 16,
    );
  }

  /// Request Status Breakdown legend heading (Breakdown, status group labels).
  static TextStyle requestStatusBreakdownStatusLabel({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w700,
      color: AppColors.breakdownTextColor,
      height: 20 / 14,
    );
  }

  /// Request Status Breakdown description labels (Total, Approved, etc.).
  static TextStyle requestStatusBreakdownDescriptionLabel({double? fontSize}) {
    return cairo(
      fontSize: fontSize?.toAutoScaledFont ?? 12.toAutoScaledFont,
      fontWeight: FontWeight.w400,
      color: AppColors.grey50,
      height: 16 / 12,
    );
  }

  /// Request Status Breakdown count values.
  static TextStyle requestStatusBreakdownCountValue({double? fontSize}) {
    return GoogleFonts.roboto(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      height: 16 / 12,
    );
  }

  /// Trend Breakdown card title.
  static TextStyle requestTrendBreakdownTitle({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w700,
      color: AppColors.textHeading,
      height: 20 / 16,
    );
  }

  /// Trend Breakdown metric label (Total Tickets).
  static TextStyle requestTrendBreakdownMetricLabel({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: AppColors.trendLabelColor,
      height: 14 / 12,
    );
  }

  /// Trend Breakdown chart axis labels (X-axis & Y-axis).
  static TextStyle requestTrendBreakdownAxisLabel({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 8,
      fontWeight: FontWeight.w400,
      color: AppColors.grey50,
      height: 9.89 / 8,
    );
  }

  /// My Requests / Action Items — selected tab.
  static TextStyle myRequestsTabSelected({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
      height: 16 / 14,
    );
  }

  /// My Requests / Action Items — unselected tab.
  static TextStyle myRequestsTabUnselected({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grey50,
      height: 1.43,
    );
  }

  /// Request list search field hint and input text.
  static TextStyle requestListSearchText({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w400,
      color: AppColors.searchTextColor,
      height: 1.43,
    );
  }

  /// Dynamic form field values and user-entered content.
  static TextStyle dynamicFormContent({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryText,
    );
  }

  /// KPI card count value.
  static TextStyle kpiCountValue({double? fontSize}) {
    return GoogleFonts.roboto(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      color: AppColors.kpiTextColor,
      height: 1,
    );
  }

  /// KPI card label text.
  static TextStyle kpiLabel({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w600,
      color: AppColors.kpiTextColor,
      height: 20 / 12,
    );
  }

  /// Request details screen app bar title.
  static TextStyle requestDetailScreenTitle({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 22,
      fontWeight: FontWeight.w500,
      color: AppColors.textHeading,
      height: 1,
    );
  }

  /// Service shell app bar title and request list card header.
  static TextStyle serviceScreenTitle({double? fontSize}) {
    return cairo(
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w700,
      color: AppColors.textHeading,
      height: 1.25,
    );
  }
}
