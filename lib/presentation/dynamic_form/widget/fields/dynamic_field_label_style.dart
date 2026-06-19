import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

abstract final class DynamicFieldLabelStyle {
  static TextStyle get label => AppTextStyles.requestDetailsFieldHeading();

  static TextStyle get content => AppTextStyles.dynamicFormContent();

  static TextStyle get text => label;
}
