import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceTreeProvider = Provider<ServiceTree>((ref) {
  final selectedRole = ref.watch(rolesProvider);
  return ServiceTree(selectedRole?.services ?? []);
});

class ServiceTree {
  final List<Service> services;

  const ServiceTree(this.services);

  Service? serviceByCode(String code) {
    final normalizedCode = code.trim();
    for (final service in services) {
      if ((service.code ?? '').trim() == normalizedCode) {
        return service;
      }
    }
    return null;
  }

  Service? serviceByCodeOrSubServiceCodes({
    required String serviceCode,
    Iterable<String> subServiceCodes = const [],
    Iterable<String> subServiceNames = const [],
  }) {
    final byCode = serviceByCode(serviceCode);
    if (byCode != null) return byCode;

    final normalizedCodes = subServiceCodes.map((code) => code.trim()).toSet();
    final normalizedNames = subServiceNames
        .map((name) => name.trim().toLowerCase())
        .toSet();
    for (final service in services) {
      final containsKnownSubService = (service.subservices ?? []).any(
        (subService) =>
            normalizedCodes.contains((subService.code ?? '').trim()) ||
            normalizedNames.contains(
              (subService.subServiceName ?? '').trim().toLowerCase(),
            ),
      );
      if (containsKnownSubService) return service;
    }
    return null;
  }
}
