import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RequestForAccessHomePage extends ConsumerWidget {
  const RequestForAccessHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: 'CAAS03',
              subServiceCodes: const ['CAA021', 'CAA023', 'CAA025'],
            ) ??
        Service(code: 'CAAS03', name: 'Security and Access');

    return DynamicServiceShell(
      lazyLoadDashboard: true,
      service: service,
      dashboardRoute: SecurityAccessDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
