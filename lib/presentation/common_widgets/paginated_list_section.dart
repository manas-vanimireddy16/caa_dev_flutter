import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Reusable infinite-scroll list wired to [PagingController].
class PaginatedListSection<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String emptyMessage;

  const PaginatedListSection({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return PagingListener(
      controller: pagingController,
      builder: (context, state, fetchNextPage) {
        return PagedListView<int, T>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: itemBuilder,
            firstPageProgressIndicatorBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            newPageProgressIndicatorBuilder: (_) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
            noItemsFoundIndicatorBuilder: (_) =>
                Center(child: Text(emptyMessage)),
          ),
        );
      },
    );
  }
}
