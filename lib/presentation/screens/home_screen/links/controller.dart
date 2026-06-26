part of 'view.dart';

final _linksRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(),
);

class _LinksPageLoader {
  _LinksPageLoader(this._repository);

  final DashboardRepository _repository;

  Future<List<ImportantLinkModel>> loadPage(
    int pageKey, {
    required String searchText,
  }) async {
    final response = await _repository.getImportantLinks(
      searchText: searchText,
      offset: ListPagination.offsetForPage(pageKey),
      limit: ListPagination.pageSize,
    );
    return response.data;
  }
}
