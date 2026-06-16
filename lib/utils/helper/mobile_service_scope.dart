import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';

abstract final class MobileServiceScope {
  static const approvedServiceCodes = <String>{
    'CAAS01',
    'CAAS02',
    'CAAS03',
    'CAAS05',
    'CAAS08',
    'CAAS09',
    'CAAS010',
    'CAAS011',
    'CAAS012',
    'CAAS013',
    'CAAS014',
    'CAAS015',
    'CAAS016',
  };

  static const approvedSubServiceCodes = <String>{
    'CAA003',
    'CAA004',
    'CAA005',
    'CAA006',
    'CAA010',
    'CAA012',
    'CAA013',
    'CAA014',
    'CAA015',
    'CAA016',
    'CAA020',
    'CAA021',
    'CAA023',
    'CAA024',
    'CAA025',
    'CAA027',
    'CAA028',
    'CAA029',
    'CAA031',
    'CAA032',
    'CAA033',
    'CAA034',
    'CAA035',
    'CAA036',
    'CAA037',
    'CAA038',
    'CAA039',
    'CAA040',
    'CAA045',
    'CAA046',
    'CAA049',
    'CAA050',
    'CAA059',
    'CAA060',
    'CAA061',
    'CAA062',
    'CAA063',
    'CAA064',
    'CAA065',
    'CAA066',
    'CAA067',
    'CAA068',
    'CAA069',
  };

  static bool isApprovedService(Service service) =>
      approvedServiceCodes.contains((service.code ?? '').trim());

  static bool isApprovedSubService(SubService subService) =>
      approvedSubServiceCodes.contains((subService.code ?? '').trim());

  static List<SubService> filterSubServices(Iterable<SubService> subServices) =>
      subServices.where(isApprovedSubService).toList(growable: false);

  static List<Service> filterServices(Iterable<Service> services) {
    return services
        .where(isApprovedService)
        .map((service) {
          final approvedSubServices = filterSubServices(
            service.subservices ?? const [],
          );
          if (approvedSubServices.isEmpty) return null;

          return Service(
            id: service.id,
            code: service.code,
            name: service.name,
            description: service.description,
            logoUrl: service.logoUrl,
            subservices: approvedSubServices,
            arabicName: service.arabicName,
            arabicDescription: service.arabicDescription,
          );
        })
        .whereType<Service>()
        .toList(growable: false);
  }

  static SelectedUserRole filterSelectedRole(SelectedUserRole role) {
    return SelectedUserRole(
      roleId: role.roleId,
      roleName: role.roleName,
      departmentId: role.departmentId,
      sectionId: role.sectionId,
      services: filterServices(role.services),
    );
  }

  static ({List<int> serviceIds, List<int> subServiceIds}) idsForServices(
    Iterable<Service> services,
  ) {
    final scopedServices = filterServices(services);
    return (
      serviceIds: scopedServices
          .map((service) => service.id)
          .whereType<int>()
          .toSet()
          .toList(growable: false),
      subServiceIds: scopedServices
          .expand((service) => service.subservices ?? const [])
          .map((subService) => subService.id)
          .whereType<int>()
          .toSet()
          .toList(growable: false),
    );
  }
}
