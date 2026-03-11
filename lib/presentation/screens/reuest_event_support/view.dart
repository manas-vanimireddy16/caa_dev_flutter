import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/chartModel.dart';
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/chartDataModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:code_setup/presentation/screens/reuest_event_support/models/activityField.dart';
import 'package:code_setup/presentation/screens/reuest_event_support/models/chartData.dart';
import 'package:code_setup/presentation/screens/reuest_event_support/widgets/activityFeed.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bottomNavigation/index.dart';

part 'widgets/newRequest.dart';
part 'controller.dart';
part 'dashboard.dart';
part 'requestPortal.dart';

@RoutePage()
class RequestEventSupportScreen extends StatefulWidget {
  const RequestEventSupportScreen({super.key});

  @override
  State<RequestEventSupportScreen> createState() =>
      _RequestEventSupportScreenState();
}

class _RequestEventSupportScreenState extends State<RequestEventSupportScreen> {
  @override
  void initState() {
    super.initState();

    /// Navigate automatically once the widget builds
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.router.push(
    //     KBottomNavigatorRoute(fromPage: 'requesteventsupport'),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Optional: return a simple loading or splash-like screen until navigation happens
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
