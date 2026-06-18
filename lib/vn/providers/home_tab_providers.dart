import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/app_storage.dart';
import '../../core/utils/error_utils.dart';
import '../../settings/providers/settings_provider.dart';
import '../models/visual_novel.dart';
import 'vn_core_providers.dart';
import 'vn_filter_providers.dart';
import 'vn_list_providers.dart';

class HomeTabIds {
  static const createFilter = 'create_filter';
  static const mostPopular = 'most_popular';
  static const recentlyReleased = 'recently_released';
  static const upcomingReleases = 'upcoming_releases';
}

class HomeTabDefinition {
  const HomeTabDefinition({
    required this.id,
    required this.title,
    required this.filters,
    required this.sort,
    this.isCustom = false,
  });

  final String id;
  final String title;
  final VnFilterState filters;
  final VnSortState sort;
  final bool isCustom;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'filters': filters.toJson(),
      'sort': sort.toJson(),
    };
  }

  factory HomeTabDefinition.fromJson(Map<String, dynamic> json) {
    return HomeTabDefinition(
      id: json['id'] as String,
      title: json['title'] as String,
      filters: VnFilterState.fromJson(
        Map<String, dynamic>.from(json['filters'] as Map),
      ),
      sort: VnSortState.fromJson(
        Map<String, dynamic>.from(json['sort'] as Map),
      ),
      isCustom: true,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is HomeTabDefinition &&
        other.id == id &&
        other.title == title &&
        other.filters == filters &&
        other.sort == sort &&
        other.isCustom == isCustom;
  }

  @override
  int get hashCode => Object.hash(id, title, filters, sort, isCustom);
}

class HomeTabsState {
  const HomeTabsState({
    required this.customTabs,
    required this.selectedTabId,
  });

  final List<HomeTabDefinition> customTabs;
  final String selectedTabId;

  List<HomeTabDefinition> get tabs => [
    _createFilterTab,
    ...customTabs,
    ...builtInHomeTabs(),
  ];

  HomeTabsState copyWith({
    List<HomeTabDefinition>? customTabs,
    String? selectedTabId,
  }) {
    return HomeTabsState(
      customTabs: customTabs ?? this.customTabs,
      selectedTabId: selectedTabId ?? this.selectedTabId,
    );
  }
}

const _createFilterTab = HomeTabDefinition(
  id: HomeTabIds.createFilter,
  title: 'New Filter',
  filters: VnFilterState(minRating: 0.0, minVotes: 0),
  sort: VnSortState(field: 'rating', descending: true),
);

const _staticBuiltInHomeTabs = [
  HomeTabDefinition(
    id: HomeTabIds.mostPopular,
    title: 'Most Popular',
    filters: VnFilterState(minRating: 0.0, minVotes: 0),
    sort: VnSortState(field: 'votecount', descending: true),
  ),
  HomeTabDefinition(
    id: HomeTabIds.recentlyReleased,
    title: 'Recently Released',
    filters: VnFilterState(
      minRating: 0.0,
      minVotes: 0,
      releasedTo: 'today',
    ),
    sort: VnSortState(field: 'released', descending: true),
  ),
  HomeTabDefinition(
    id: HomeTabIds.upcomingReleases,
    title: 'Upcoming Releases',
    filters: VnFilterState(minRating: 0.0, minVotes: 0),
    sort: VnSortState(field: 'released', descending: false),
  ),
];

String _tomorrowReleaseDate() {
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  final month = tomorrow.month.toString().padLeft(2, '0');
  final day = tomorrow.day.toString().padLeft(2, '0');

  return '${tomorrow.year}-$month-$day';
}

List<HomeTabDefinition> builtInHomeTabs() {
  return [
    _staticBuiltInHomeTabs[0],
    _staticBuiltInHomeTabs[1],
    HomeTabDefinition(
      id: HomeTabIds.upcomingReleases,
      title: 'Upcoming Releases',
      filters: VnFilterState(
        minRating: 0.0,
        minVotes: 0,
        releasedFrom: _tomorrowReleaseDate(),
      ),
      sort: _staticBuiltInHomeTabs[2].sort,
    ),
  ];
}

class HomeTabsNotifier extends Notifier<HomeTabsState> {
  static const _customTabsKey = 'home_custom_filter_tabs';
  static const _selectedTabKey = 'home_selected_tab_id';

  @override
  HomeTabsState build() {
    final box = AppStorage.mainBox;
    final customTabs = _loadCustomTabs(box.get(_customTabsKey));
    final savedSelectedId = box.get(_selectedTabKey) as String?;
    final tabIds = {
      HomeTabIds.createFilter,
      for (final tab in builtInHomeTabs()) tab.id,
      for (final tab in customTabs) tab.id,
    };
    final selectedTabId =
        savedSelectedId != null && tabIds.contains(savedSelectedId)
        ? savedSelectedId
        : HomeTabIds.mostPopular;

    return HomeTabsState(
      customTabs: customTabs,
      selectedTabId: selectedTabId,
    );
  }

  List<HomeTabDefinition> _loadCustomTabs(Object? rawTabs) {
    if (rawTabs is! List) {
      return const [];
    }

    try {
      return rawTabs
          .map(
            (item) => HomeTabDefinition.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> selectTab(String tabId) async {
    if (!state.tabs.any((tab) => tab.id == tabId)) {
      return;
    }

    state = state.copyWith(selectedTabId: tabId);
    await AppStorage.mainBox.put(_selectedTabKey, tabId);
  }

  Future<void> addCustomTab({
    required String name,
    required VnFilterState filters,
    required VnSortState sort,
  }) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    final tab = HomeTabDefinition(
      id: 'custom_${DateTime.now().microsecondsSinceEpoch}',
      title: trimmedName,
      filters: filters,
      sort: sort,
      isCustom: true,
    );
    final customTabs = [tab, ...state.customTabs];

    state = state.copyWith(
      customTabs: customTabs,
      selectedTabId: tab.id,
    );
    await _saveCustomTabs(customTabs);
    await AppStorage.mainBox.put(_selectedTabKey, tab.id);
  }

  Future<void> updateCustomTab({
    required String tabId,
    required String name,
    required VnFilterState filters,
    required VnSortState sort,
  }) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    final customTabs = state.customTabs
        .map((tab) {
          if (tab.id != tabId) {
            return tab;
          }

          return HomeTabDefinition(
            id: tab.id,
            title: trimmedName,
            filters: filters,
            sort: sort,
            isCustom: true,
          );
        })
        .toList(growable: false);

    state = state.copyWith(
      customTabs: customTabs,
      selectedTabId: tabId,
    );
    await _saveCustomTabs(customTabs);
    await AppStorage.mainBox.put(_selectedTabKey, tabId);
  }

  Future<void> removeCustomTab(String tabId) async {
    final customTabs = state.customTabs
        .where((tab) => tab.id != tabId)
        .toList(growable: false);
    final selectedTabId = state.selectedTabId == tabId
        ? HomeTabIds.mostPopular
        : state.selectedTabId;

    state = state.copyWith(
      customTabs: customTabs,
      selectedTabId: selectedTabId,
    );
    await _saveCustomTabs(customTabs);
    await AppStorage.mainBox.put(_selectedTabKey, selectedTabId);
  }

  Future<void> _saveCustomTabs(List<HomeTabDefinition> customTabs) async {
    await AppStorage.mainBox.put(
      _customTabsKey,
      customTabs.map((tab) => tab.toJson()).toList(),
    );
  }
}

final homeTabsProvider = NotifierProvider<HomeTabsNotifier, HomeTabsState>(
  HomeTabsNotifier.new,
);

final homeTabDefinitionProvider = Provider.autoDispose
    .family<HomeTabDefinition?, String>((ref, tabId) {
      final tabs = ref.watch(homeTabsProvider.select((state) => state.tabs));

      for (final tab in tabs) {
        if (tab.id == tabId) {
          return tab;
        }
      }

      return null;
    });

class HomeVnListNotifier extends Notifier<VnListState> {
  HomeVnListNotifier(this.tabId);

  final String tabId;
  int _requestGeneration = 0;

  @override
  VnListState build() {
    ref.listen<HomeTabDefinition?>(homeTabDefinitionProvider(tabId), (
      previous,
      next,
    ) {
      if (previous != next && next != null) {
        _requestGeneration++;
        Future.microtask(() => resetAndFetch());
      }
    });

    ref.listen<int>(
      settingsProvider.select((settings) => settings.spoilerLevel),
      (previous, next) {
        _requestGeneration++;
        Future.microtask(() => resetAndFetch());
      },
    );

    Future.microtask(() => fetchVns());

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    final tab = ref.read(homeTabDefinitionProvider(tabId));

    if (tab == null ||
        tab.id == HomeTabIds.createFilter ||
        state.isLoading ||
        state.isLoadMore ||
        !state.hasMore) {
      return;
    }

    final requestGeneration = _requestGeneration;
    final isInitial = state.vns.isEmpty;

    if (isInitial) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      state = state.copyWith(isLoadMore: true);
    }

    final currentPage = state.page;
    final repository = ref.read(vnRepositoryProvider);
    final spoilerLevel = ref.read(
      settingsProvider.select((settings) => settings.spoilerLevel),
    );
    final apiFilters = tab.filters.buildApiFilters(
      spoilerLevel: spoilerLevel,
    );

    try {
      final response = await repository.getVisualNovels(
        filters: apiFilters.length > 1
            ? ['and', ...apiFilters]
            : (apiFilters.isNotEmpty ? apiFilters.first : []),
        page: currentPage,
        sort: tab.sort.field,
        reverse: tab.sort.descending,
      );

      if (requestGeneration != _requestGeneration) {
        return;
      }

      final allVns = response['vns'] as List<VisualNovel>;
      final hasMore = response['hasMore'] as bool;

      state = state.copyWith(
        vns: isInitial ? allVns : [...state.vns, ...allVns],
        isLoading: false,
        isLoadMore: false,
        hasMore: hasMore,
        page: currentPage + 1,
      );
    } catch (e) {
      if (requestGeneration != _requestGeneration) {
        return;
      }

      state = state.copyWith(
        isLoading: false,
        isLoadMore: false,
        errorMessage: cleanErrorMessage(e),
      );
    }
  }

  Future<void> resetAndFetch() async {
    _requestGeneration++;
    state = VnListState.initial();
    await fetchVns();
  }
}

final homeVnListProvider =
    NotifierProvider.family<HomeVnListNotifier, VnListState, String>(
      HomeVnListNotifier.new,
    );
