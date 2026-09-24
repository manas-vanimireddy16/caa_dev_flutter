import 'package:code_setup/responsive/responsive.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/app_extensions/app_extension.dart';
import '../../../../../domain/core/theme/theme.dart';
import '../../theme.dart';

part 'extensions.dart';
part 'fonts.dart';
part 'margins.dart';
part 'paddings.dart';

class DimensionalThemeService implements KThemeService {
  @override
  KThemeFontLineHeights get fontLineHeights => _DimensionalFontLineHeights();

  @override
  KThemeFontSizes get fontSizes => _DimensionalFontSizes();

  @override
  KThemeFontWeights get fontWeights => _DimensionalFontWeights();

  @override
  KThemeMargins get margins => _DimensionalMargins();

  @override
  KThemePaddings get paddings => _DimensionalPaddings();
}

/// Design baseline: width 440, height 903 (FM HRMS shared scaling).
abstract class DimensionalPolicies {
  DimensionalPolicies._();

  static const double designWidth = 440.0;
  static const double designHeight = 903.0;

  static double get policyRatioForWidth {
    final context = KAppX.currentContext;
    final deviceWidth = context != null
        ? MediaQuery.of(context).size.width
        : designWidth;
    return deviceWidth / designWidth;
  }

  static double getPolicyRatioForWidthWithContext(BuildContext context) {
    return MediaQuery.of(context).size.width / designWidth;
  }

  static double get policyRatioForHeight {
    final context = KAppX.currentContext;
    final deviceHeight = context != null
        ? MediaQuery.of(context).size.height
        : designHeight;
    return deviceHeight / designHeight;
  }

  static double getPolicyRatioForHeightWithContext(BuildContext context) {
    return MediaQuery.of(context).size.height / designHeight;
  }
}
