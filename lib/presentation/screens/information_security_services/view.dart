import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SecuritySelfHomePage extends ConsumerWidget {
  const SecuritySelfHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const serviceCode = 'CAAS011';
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: serviceCode,
              subServiceCodes: const ['CAA006'],
            ) ??
        Service(code: serviceCode, name: 'Information Security Services');

    return DynamicServiceShell(
      service: service,
      dashboardRoute: InformationSecurityDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
