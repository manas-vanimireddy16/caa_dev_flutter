import 'package:code_setup/presentation/chatbot/chatbot_assets.dart';
import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders the chatbot logo. Uses the vector asset that works with flutter_svg.
class ChatbotIcon extends StatelessWidget {
  final double size;

  const ChatbotIcon({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ChatbotAssets.aiAvatar,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _FallbackIcon(size: size),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  final double size;

  const _FallbackIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: ChatbotTheme.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.auto_awesome,
        color: Colors.white,
        size: size * 0.5,
      ),
    );
  }
}
