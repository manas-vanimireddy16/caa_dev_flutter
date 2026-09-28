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
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            _iconAsset,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(_iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
