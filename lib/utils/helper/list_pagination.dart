import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Shared pagination settings for service request lists.
abstract final class ListPagination {
  ListPagination._();

  /// Default page size for service request / action item lists.
  static const int pageSize = 10;

  /// API `offset` is **1-based** (first row = 1, second page starts at 11, …).
  ///
  /// Matches legacy bulk fetches that used `offset: 1` and avoids overlapping
  /// rows when the backend treats offset as a row index (not a zero-based skip).
  ///
  /// [pageKey] must be **0-based** (0 = first page, 1 = second page).
  static int offsetForPage(int pageKey) => (pageKey * pageSize) + 1;

  /// Returns the next page key, or `null` when there are no more pages.
  ///
  /// Uses **0-based** page keys so [offsetForPage] yields 1 → 11 → 21…
  ///
  /// Also stops when the last page is empty or shorter than [pageSize].
  static int? nextPageKey<T>(PagingState<int, T> state) {
    if (state.lastPageIsEmpty) return null;

    final lastPage = state.pages?.lastOrNull;
    if (lastPage != null && lastPage.length < pageSize) {
      return null;
    }

    final lastKey = state.keys?.lastOrNull;
    return lastKey == null ? 0 : lastKey + 1;
  }
}
