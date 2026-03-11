import 'package:code_setup/presentation/common_widgets/work_progress.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';

class WorkflowTabContent<T> extends StatelessWidget {
  final List<dynamic> workflows;

  const WorkflowTabContent({super.key, required this.workflows});

  @override
  Widget build(BuildContext context) {
    if (workflows.isEmpty) {
      return const Center(child: Text("No workflow data available"));
    }

    // ✅ Detect the type once — not inside the builder
    if (workflows.first is Workflow) {
      return _buildLogisticsWorkflow();
    } else if (workflows.first is VPNWorkflowDetail) {
      return _buildVpnWorkflow();
    } else {
      return const Center(child: Text("Unsupported workflow type"));
    }
  }

  // 🟦 1. Logistics workflow
  Widget _buildLogisticsWorkflow() {
    final logisticsWorkflows = workflows.cast<Workflow>();
    return _buildWorkflowCard(
      children: List.generate(logisticsWorkflows.length, (index) {
        final workflow = logisticsWorkflows[index];
        return TimelineItem(
          task: workflow,
          isLast: index == logisticsWorkflows.length - 1,
        );
      }),
    );
  }

  // 🟩 2. VPN workflow
  Widget _buildVpnWorkflow() {
    final vpnWorkflows = workflows.cast<VPNWorkflowDetail>();
    return _buildWorkflowCard(
      children: List.generate(vpnWorkflows.length, (index) {
        final workflow = vpnWorkflows[index];
        return TimelineItem(
          task: workflow,
          isLast: index == vpnWorkflows.length - 1,
        );
      }),
    );
  }

  // ♻️ Shared UI builder
  Widget _buildWorkflowCard({required List<Widget> children}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: SizedBox(
          height: 400.toAutoScaledHeight,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ),
      ),
    );
  }
}
