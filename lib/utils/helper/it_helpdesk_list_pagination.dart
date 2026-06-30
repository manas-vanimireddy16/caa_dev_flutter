import 'package:code_setup/utils/helper/list_pagination.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Pagination for IT Helpdesk Muscat & Salalah list APIs.
///
/// These backends use **0-based** `offset` (first row = 0, second page = 10).
/// Other services use [ListPagination] with **1-based** offset.
abstract final class ItHelpdeskListPagination {
  ItHelpdeskListPagination._();

  static const int pageSize = ListPagination.pageSize;

  /// [pageKey] is 0-based (0 = first page, 1 = second page).
  static int offsetForPage(int pageKey) => pageKey * pageSize;

  static int? nextPageKey<T>(PagingState<int, T> state) =>
      ListPagination.nextPageKey(state);
}
