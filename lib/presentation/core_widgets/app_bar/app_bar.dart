import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';
import '../buttons/back_button.dart';

class KAppBar extends ConsumerWidget implements PreferredSizeWidget {
  PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Future<bool> Function()? onPopCallback;
  final bool showArrow;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;
  final double titleSpacing;
  final double? appBarHeight;
  final ShapeBorder? shape;

  KAppBar({
    Key? key,
    PreferredSizeWidget? bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.onPopCallback,
    this.showArrow = false,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.titleSpacing = 0,
    this.appBarHeight,
    this.shape,
  }) : super(key: key) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    this.bottom =
        bottom ??
        PreferredSize(
          preferredSize: Size.fromHeight(1.toAutoScaledHeight),
          child: Container(
            height: 1.toAutoScaledHeight,
            color: currentTheme.colors.secondary.shade95,
          ),
        );
  }

  static Widget requestDetailsTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.requestDetailScreenTitle(),
    );
  }

  void onBackButtonPressed() async {
    final res = (await onPopCallback?.call()) ?? true;

    if (res) {
      KAppX.router.pop();
    }
  }

  double get _appBarHeight =>
      (appBarHeight ?? 65.toAutoScaledHeight) +
      (bottom?.preferredSize.height ?? 0.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    return SafeArea(
      child: AppBar(
        toolbarHeight: _appBarHeight,
        leading: !automaticallyImplyLeading
            ? null
            : leading ??
                  () {
                    late Widget? widget;

                    if (canPop) {
                      if (showArrow) {
                        widget = KBackButton(
                          onPressed: onBackButtonPressed,
                          color: foregroundColor,
                        );
                      } else {
                        widget = KBackButton(
                          cancel: useCloseButton,
                          onPressed: onBackButtonPressed,
                          color: foregroundColor,
                        );
                      }
                    } else {
                      widget = null;
                    }

                    return widget;
                  }(),
        backgroundColor:
            backgroundColor ?? currentTheme.themeBox.colors.background,
        elevation: elevation ?? 0,
        title: title,
        shape: shape,
        centerTitle: centerTitle ?? false,
        actions: actions,
        foregroundColor: foregroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
        bottom: bottom,
        leadingWidth: leadingWidth,
        automaticallyImplyLeading: automaticallyImplyLeading,
        titleSpacing: titleSpacing,
        shadowColor: Colors.black.withOpacity(0.05),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
