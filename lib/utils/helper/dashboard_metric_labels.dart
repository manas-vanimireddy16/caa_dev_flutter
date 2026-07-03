import 'package:code_setup/utils/helper/dashboard_l10n.dart';

/// Resolves KPI / breakdown labels: Total Tickets vs Total Requests.
class DashboardMetricLabels {
  DashboardMetricLabels._();

  static const Set<String> totalTicketsSubServiceCodes = {
    'CAA003', // Salalah
    'CAA004', // Muscat
    'CAA005', // VPN
  };

  static bool usesTotalTickets({String? subServiceCode}) {
    final code = subServiceCode?.trim().toUpperCase();
    return code != null && totalTicketsSubServiceCodes.contains(code);
  }

  static bool isTotalMetricKey(String key) {
    final normalized = key.toLowerCase().replaceAll('_', '');
    return normalized == 'totaltickets' ||
        normalized == 'totalrequests' ||
        normalized == 'total';
  }

  static String totalMetricLabel(
    DashboardL10n l10n, {
    String? subServiceCode,
  }) {
    return usesTotalTickets(subServiceCode: subServiceCode)
        ? l10n.totalTickets
        : l10n.totalRequests;
  }

  static String statTitle(
    DashboardL10n l10n,
    String key, {
    String? subServiceCode,
    bool isSecurityThreat = false,
  }) {
    if (isTotalMetricKey(key)) {
      return totalMetricLabel(l10n, subServiceCode: subServiceCode);
    }

    final normalized = key.toLowerCase().replaceAll('_', '');

    if (usesTotalTickets(subServiceCode: subServiceCode) &&
        normalized == 'expired') {
      return l10n.statTitle('rejected', isSecurityThreat: isSecurityThreat);
    }

    return l10n.statTitle(key, isSecurityThreat: isSecurityThreat);
  }
}
