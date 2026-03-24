import 'dart:math' as math;

class ChartUtils {
  static double calculateInterval(double maxY) {
    if (maxY <= 5) return 1;
    if (maxY <= 10) return 2;

    final rawInterval = maxY / 5;
    final magnitude = math
        .pow(10, (math.log(rawInterval) / math.ln10).floor())
        .toDouble();

    final residual = rawInterval / magnitude;

    double niceResidual;

    if (residual >= 5) {
      niceResidual = 5;
    } else if (residual >= 2) {
      niceResidual = 2;
    } else {
      niceResidual = 1;
    }

    final interval = niceResidual * magnitude;

    /// ⭐ VERY IMPORTANT CLAMP
    return interval < 1 ? 1 : interval;
  }

  static double calculateNiceMaxY(double maxValue) {
    if (maxValue <= 5) return 5;

    final interval = calculateInterval(maxValue);
    return (maxValue / interval).ceil() * interval;
  }
}
