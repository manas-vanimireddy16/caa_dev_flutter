import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LegalConsultationServicesHomeScreen extends ConsumerWidget {
  const LegalConsultationServicesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: 'CAAS05',
              // subServiceCodes: const ['CAA027', 'CAA029'],
            ) ??
        Service(name: 'Legal Services');

    return DynamicServiceShell(
      service: service,
      dashboardRoute: LegalServicesDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
