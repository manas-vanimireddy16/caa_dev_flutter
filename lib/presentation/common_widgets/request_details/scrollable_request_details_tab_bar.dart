import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/utils/helper/request_details_tab_index.dart';
import 'package:flutter/material.dart';

/// Horizontal request-details tabs that keep the selected tab visible.
///
/// When opened on the default tab ([RequestDetailsTabIndex.requestDetails]),
/// the list stays at its initial (left) scroll position.
/// When opened on a later tab (e.g. Workflow via shortcut), the bar scrolls
/// so that tab is centered after the first frame.
class ScrollableRequestDetailsTabBar extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Duration scrollDuration;

  const ScrollableRequestDetailsTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
    this.scrollDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ScrollableRequestDetailsTabBar> createState() =>
      _ScrollableRequestDetailsTabBarState();
}

class _ScrollableRequestDetailsTabBarState
    extends State<ScrollableRequestDetailsTabBar> {
  late List<GlobalKey> _tabKeys;
  final ScrollController _scrollController = ScrollController();

  int? _lastScrolledIndex;
  double? _lastViewportWidth;
  int _ensureVisibleRetries = 0;
  static const int _maxEnsureVisibleRetries = 8;

  @override
  void initState() {
    super.initState();
    _tabKeys = _createKeys(widget.labels.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _maybeScrollSelectedIntoView();
    });
  }

  @override
  void didUpdateWidget(covariant ScrollableRequestDetailsTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.labels.length != widget.labels.length) {
      _tabKeys = _createKeys(widget.labels.length);
      _lastScrolledIndex = null;
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _maybeScrollSelectedIntoView(force: true);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    if (_lastViewportWidth != null && _lastViewportWidth != width) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _maybeScrollSelectedIntoView(force: true);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<GlobalKey> _createKeys(int count) =>
      List<GlobalKey>.generate(count, (_) => GlobalKey());

  void _maybeScrollSelectedIntoView({bool force = false}) {
    final selectedIndex = widget.selectedIndex;

    // Preserve the initial left-aligned position for the default tab.
    if (selectedIndex <= RequestDetailsTabIndex.requestDetails) {
      _lastScrolledIndex = selectedIndex;
      _lastViewportWidth = MediaQuery.sizeOf(context).width;
      _ensureVisibleRetries = 0;
      return;
    }

    if (selectedIndex >= _tabKeys.length) return;

    final viewportWidth = MediaQuery.sizeOf(context).width;
    if (!force &&
        _lastScrolledIndex == selectedIndex &&
        _lastViewportWidth == viewportWidth) {
      return;
    }

    final tabContext = _tabKeys[selectedIndex].currentContext;
    final renderObject = tabContext?.findRenderObject();
    if (tabContext == null ||
        renderObject == null ||
        !_scrollController.hasClients) {
      if (_ensureVisibleRetries >= _maxEnsureVisibleRetries) {
        _ensureVisibleRetries = 0;
        return;
      }
      _ensureVisibleRetries++;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _maybeScrollSelectedIntoView(force: force);
      });
      return;
    }

    _ensureVisibleRetries = 0;
    _lastScrolledIndex = selectedIndex;
    _lastViewportWidth = viewportWidth;

    // Use the horizontal ScrollPosition only — avoid scrolling the parent
    // vertical SingleChildScrollView that wraps the request details page.
    _scrollController.position.ensureVisible(
      renderObject,
      alignment: 0.5,
      duration: widget.scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.labels.length, (index) {
          return KeyedSubtree(
            key: _tabKeys[index],
            child: TabItem(
              text: widget.labels[index],
              index: index,
              selectedIndex: widget.selectedIndex,
              onTap: () => widget.onTap(index),
            ),
          );
        }),
      ),
    );
  }
}
