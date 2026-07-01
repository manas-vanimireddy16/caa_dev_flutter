import 'package:code_setup/utils/helper/dashboard_l10n.dart';

/// VPN-specific dashboard label helpers.
///
/// Keeps VPN-only display rules out of shared [DashboardL10n] and widgets.
class VpnDashboardLabels {
  VpnDashboardLabels._();

  static String statTitle(DashboardL10n l10n, String key) {
    final normalized = key.toLowerCase().replaceAll('_', '');

    if (normalized == 'expired') {
      return l10n.statTitle('rejected');
    }

    if (normalized == 'totalrequests' || normalized == 'total') {
      return l10n.totalTickets;
    }

    return l10n.statTitle(key, isSecurityThreat: true);
  }

  static String statusLabel(DashboardL10n l10n, String status) {
    if (status.toLowerCase().trim() == 'expired') {
      return l10n.statTitle('rejected');
    }

    return l10n.statusLabel(status);
  }
}
