import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MaintenanceHomeScreen extends ConsumerWidget {
  const MaintenanceHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maintenanceServiceCode = 'CAAS016';
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: maintenanceServiceCode,
              subServiceCodes: const ['CAA035', 'CAA045'],
            ) ??
        Service(code: maintenanceServiceCode, name: 'Maintenance');

    return DynamicServiceShell(
      lazyLoadDashboard: true,
      service: service,
      dashboardRoute: MaintenanceDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
