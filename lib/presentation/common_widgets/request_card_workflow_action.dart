import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Workflow shortcut shown on request cards (IT Services first).
class RequestCardWorkflowAction extends StatelessWidget {
  static const _iconAsset = 'assets/icons/workflow_request_card.svg';
  static const _iconColor = Color(0xFF1F2937);

  final VoidCallback onTap;

  const RequestCardWorkflowAction({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.toAutoScaledWidth),
        child: Padding(
          padding: EdgeInsets.all(4.toAutoScaledWidth),
          child: SvgPicture.asset(
            _iconAsset,
            width: 20.toAutoScaledWidth,
            height: 20.toAutoScaledWidth,
            colorFilter: const ColorFilter.mode(_iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
