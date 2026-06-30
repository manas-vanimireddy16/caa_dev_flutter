import 'package:code_setup/utils/helper/icons.dart';

/// Drawer icon paths for sub-services.
///
/// Dashboard items should continue using [AppIcons.dashboard] directly.
/// Replace [AppIcons.drawerSubServicePlaceholder] per case when assets are ready.
class DrawerServiceIcon {
  DrawerServiceIcon._();

  /// Resolves the drawer icon asset path for a mobile sub-service.
  static String pathForSubService({
    String? subServiceCode,
    String? serviceCode,
    String? serviceName,
  }) {
    final code = _normalizedCode(subServiceCode, serviceCode, serviceName);

    switch (code) {
      /// IT Services
      case 'CAA003':
      case 'CAA004':
      case 'CAA005':
      case 'CAA059':
        return AppIcons.drawerSubServicePlaceholder;

      /// Training Services
      case 'CAA015':
      case 'CAA016':
      case 'CAA018':
      case 'CAA019':
      case 'CAA049':
      case 'CAA050':
        return AppIcons.drawerSubServicePlaceholder;

      /// Logistics
      case 'CAA031':
      case 'CAA032':
      case 'CAA033':
        return AppIcons.drawerSubServicePlaceholder;

      /// Legal Services
      case 'CAA027':
      case 'CAA028':
      case 'CAA029':
      case 'CAA030':
        return AppIcons.drawerSubServicePlaceholder;

      /// HC / HR Services
      case 'CAA006':
      case 'CAA010':
      case 'CAA011':
      case 'CAA012':
      case 'CAA013':
      case 'CAA014':
      case 'CAA020':
      case 'CAA021':
      case 'CAA023':
      case 'CAA025':
      case 'CAA034':
      case 'CAA035':
      case 'CAA036':
      case 'CAA037':
      case 'CAA038':
      case 'CAA039':
      case 'CAA040':
      case 'CAA045':
      case 'CAA046':
      case 'CAA060':
      case 'CAA061':
      case 'CAA062':
      case 'CAA063':
      case 'CAA064':
      case 'CAA065':
      case 'CAA066':
      case 'CAA067':
      case 'CAA068':
      case 'CAA069':
        return AppIcons.drawerSubServicePlaceholder;

      default:
        return AppIcons.drawerSubServicePlaceholder;
    }
  }

  static String _normalizedCode(
    String? subServiceCode,
    String? serviceCode,
    String? serviceName,
  ) {
    final subService = subServiceCode?.trim();
    if (subService != null && subService.isNotEmpty) {
      return subService.toUpperCase();
    }

    final service = serviceCode?.trim();
    if (service != null && service.isNotEmpty) {
      return service.toUpperCase();
    }

    final name = serviceName?.trim();
    if (name != null && name.isNotEmpty) {
      return name.toUpperCase();
    }

    return '';
  }
}
