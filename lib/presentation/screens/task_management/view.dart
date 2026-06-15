import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TrainingsandDevelopmentHomeScreen extends ConsumerWidget {
  const TrainingsandDevelopmentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const serviceCode = 'CAAS015';
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: serviceCode,
              subServiceCodes: const ['CAA034', 'CAA065'],
            ) ??
        Service(code: serviceCode, name: 'Task Management');

    return DynamicServiceShell(
      service: service,
      dashboardRoute: TaskManagementDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
