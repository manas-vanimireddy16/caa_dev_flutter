import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HRServiceHomeScreen extends ConsumerWidget {
  const HRServiceHomeScreen({super.key});

  static const _serviceCode = 'CAAS08';
  static const _subServiceCodes = [
    'CAA036',
    'CAA037',
    'CAA038',
    'CAA039',
    'CAA040',
    'CAA060',
    'CAA061',
    'CAA062',
    'CAA063',
    'CAA064',
    'CAA066',
    'CAA067',
    'CAA068',
    'CAA069',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(rolesProvider);
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: _serviceCode,
              subServiceCodes: _subServiceCodes,
            ) ??
        Service(code: _serviceCode, name: 'HC Services');

    final subServices = service.subservices ?? [];
    if (service.id == null || subServices.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DynamicServiceShell(
      lazyLoadDashboard: true,
      service: service,
      dashboardRoute: HCServicesDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: subServices,
      ),
    );
  }
}
