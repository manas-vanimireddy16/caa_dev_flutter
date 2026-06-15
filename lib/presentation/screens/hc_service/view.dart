import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/dynamic_service_shell.dart';
import 'package:code_setup/presentation/core/providers/service_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HRServiceHomeScreen extends ConsumerWidget {
  const HRServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const serviceCode = 'CAAS08';
    final service =
        ref
            .watch(serviceTreeProvider)
            .serviceByCodeOrSubServiceCodes(
              serviceCode: serviceCode,
              subServiceCodes: const [
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
              ],
            ) ??
        Service(code: serviceCode, name: 'HC Services');

    return DynamicServiceShell(
      service: service,
      dashboardRoute: HCServicesDashboardRoute(
        service: service,
        subService: SubService(),
        subServices: service.subservices ?? [],
      ),
    );
  }
}
