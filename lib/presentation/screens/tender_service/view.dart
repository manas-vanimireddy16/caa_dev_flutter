import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TenderServiceHomeScreen extends ConsumerWidget {
  const TenderServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const serviceCode = 'CAAS012';
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: serviceCode,
              subServiceCodes: const ['CAA011', 'CAA012', 'CAA013', 'CAA014'],
            ) ??
        Service(code: serviceCode, name: 'Tender Services');

    return DynamicServiceShell(
      lazyLoadDashboard: true,
      service: service,
      dashboardRoute: TenderServiceDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
