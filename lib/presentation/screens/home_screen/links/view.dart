import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/chatbot/widgets/dashboard_app_bar_actions.dart';
import 'package:code_setup/presentation/common_widgets/paginated_list_section.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/important_links_model.dart';
import 'package:code_setup/presentation/screens/home_screen/links/widgets/important_link_card.dart';
import 'package:code_setup/presentation/screens/home_screen/services/servicesCard.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/utils/helper/list_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'controller.dart';

@RoutePage()
class LinksScreen extends ConsumerStatefulWidget {
  const LinksScreen({super.key});

  @override
  ConsumerState<LinksScreen> createState() => _LinksScreenState();
}

class _LinksScreenState extends ConsumerState<LinksScreen> {
  late final PagingController<int, ImportantLinkModel> _pagingController;
  late final _LinksPageLoader _pageLoader;
  final _searchDebounce = KDebounce(const Duration(milliseconds: 400));
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _pageLoader = _LinksPageLoader(ref.read(_linksRepositoryProvider));
    _pagingController = PagingController<int, ImportantLinkModel>(
      getNextPageKey: ListPagination.nextPageKey,
      fetchPage: _fetchPage,
    );
  }

  @override
  void dispose() {
    _searchDebounce.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<ImportantLinkModel>> _fetchPage(int pageKey) {
    return _pageLoader.loadPage(
      pageKey,
      searchText: _searchQuery,
    );
  }

  void _onSearchChanged(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _searchDebounce(() => _pagingController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: AppColors.homeSurfaceColor,
      appBar: AppBar(
        title: Text(
          l10n.links,
          style: AppTextStyles.cairo(
            fontSize: 20.toAutoScaledFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 64,
        foregroundColor: AppColors.textHeading,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE6E6EA), width: 1),
        ),
        actions: const [DashboardAppBarActions()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: ServicesSearchField(
              initialValue: _searchQuery,
              hintText: l10n.inputSearchPlaceholder,
              onChanged: _onSearchChanged,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PaginatedListSection<ImportantLinkModel>(
              pagingController: _pagingController,
              emptyMessage: l10n.noDataFound,
              itemBuilder: (context, link, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: ImportantLinkCard(
                    link: link,
                    postedOnLabel: l10n.postedOn,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}