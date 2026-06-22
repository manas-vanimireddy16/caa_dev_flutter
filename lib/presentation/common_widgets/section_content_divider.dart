import 'package:flutter/material.dart';

/// Inset section divider used below service titles and employee card headers.
class SectionContentDivider extends StatelessWidget {
  static const dividerColor = Color(0xFFCFDFE2);
  static const maxWidth = 342.0;

  final double horizontalPadding;

  const SectionContentDivider({
    super.key,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: const SizedBox(
            width: double.infinity,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: dividerColor, width: 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
