import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ITServicesHomeScreen extends ConsumerWidget {
  const ITServicesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: 'CAAS01',
              // subServiceCodes: const ['CAA003', 'CAA004', 'CAA005', 'CAA059'],
            ) ??
        Service(code: 'CAAS01', name: 'IT Services');

    return DynamicServiceShell(
      service: service,
      dashboardRoute: ITServiceDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
