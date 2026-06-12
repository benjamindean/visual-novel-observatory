import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api/vndb_client.dart';
import '../models/visual_novel.dart';
import '../models/vn_tag.dart';
import '../models/vndb_label.dart';
import '../models/vn_ulist_entry.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

// Providers for dependencies
final vndbClientProvider = Provider<VndbClient>((ref) {
  final auth = ref.watch(authProvider);

  return VndbClient(token: auth.token);
});

final vnRepositoryProvider = Provider<VnRepository>((ref) {
  final client = ref.watch(vndbClientProvider);

  return VnRepository(client);
});

// State provider for home screen search query
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

class SearchScreenQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final searchScreenQueryProvider =
    NotifierProvider<SearchScreenQueryNotifier, String>(
      SearchScreenQueryNotifier.new,
    );

class VnSearchNotifier extends Notifier<VnListState> {
  Timer? _debounceTimer;

  @override
  VnListState build() {
    ref.listen<String>(searchScreenQueryProvider, (previous, next) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        resetAndFetch();
      });
    });

    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    if (state.isLoading || state.isLoadMore || !state.hasMore) {
      return;
    }

    final query = ref.read(searchScreenQueryProvider);

    if (query.trim().isEmpty) {
      return;
    }

    final isInitial = state.vns.isEmpty;

    if (isInitial) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      state = state.copyWith(isLoadMore: true);
    }

    final currentPage = state.page;

    final repository = ref.read(vnRepositoryProvider);

    final settings = ref.read(settingsProvider);

    try {
      final response = await repository.searchVisualNovels(
        query: query,
        page: currentPage,
      );

      final List<VisualNovel> allVns = response['vns'] as List<VisualNovel>;

      final bool hasMore = response['hasMore'] as bool;

      final List<VisualNovel> newVns = settings.showExplicitContent
          ? allVns
          : allVns.where((vn) => (vn.imageSexual ?? 0.0) <= 0.2).toList();

      state = state.copyWith(
        vns: isInitial ? newVns : [...state.vns, ...newVns],
        isLoading: false,
        isLoadMore: false,
        hasMore: hasMore,
        page: currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> resetAndFetch() async {
    state = VnListState.initial();
    await fetchVns();
  }
}

final vnSearchProvider = NotifierProvider<VnSearchNotifier, VnListState>(
  VnSearchNotifier.new,
);

class RecentlyOpenedSearchNotifier extends Notifier<List<VisualNovel>> {
  static const String _key = 'recently_opened_search_vns';

  @override
  List<VisualNovel> build() {
    Future.microtask(() => loadVns());
    return const [];
  }

  Future<void> loadVns() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final String? jsonStr = prefs.getString(_key);

      if (jsonStr != null) {
        final List<dynamic> jsonList = jsonDecode(jsonStr);

        state = jsonList
            .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
  }

  Future<void> addVn(VisualNovel vn) async {
    final list = List<VisualNovel>.from(state);

    list.removeWhere((item) => item.id == vn.id);
    list.insert(0, vn);
    if (list.length > 20) {
      list.removeLast();
    }
    state = list;

    try {
      final prefs = await SharedPreferences.getInstance();

      final String jsonStr = jsonEncode(list.map((e) => e.toJson()).toList());

      await prefs.setString(_key, jsonStr);
    } catch (_) {}
  }

  Future<void> clear() async {
    state = const [];
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_key);
    } catch (_) {}
  }
}

final recentlyOpenedSearchProvider =
    NotifierProvider<RecentlyOpenedSearchNotifier, List<VisualNovel>>(
      RecentlyOpenedSearchNotifier.new,
    );

class VnFilterState {
  final String? lang;
  final String? platform;
  final int? length;
  final int? devStatus;
  final double minRating; // 0.0 to 10.0
  final int minVotes;
  final bool showExplicitContent;
  final List<VnTag> tags;

  VnFilterState({
    this.lang,
    this.platform,
    this.length,
    this.devStatus,
    this.minRating = 7.0,
    this.minVotes = 50,
    this.showExplicitContent = false,
    this.tags = const [],
  });

  VnFilterState copyWith({
    String? Function()? lang,
    String? Function()? platform,
    int? Function()? length,
    int? Function()? devStatus,
    double? minRating,
    int? minVotes,
    bool? showExplicitContent,
    List<VnTag>? tags,
  }) {
    return VnFilterState(
      lang: lang != null ? lang() : this.lang,
      platform: platform != null ? platform() : this.platform,
      length: length != null ? length() : this.length,
      devStatus: devStatus != null ? devStatus() : this.devStatus,
      minRating: minRating ?? this.minRating,
      minVotes: minVotes ?? this.minVotes,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
      tags: tags ?? this.tags,
    );
  }

  bool get isEmpty =>
      lang == null &&
      platform == null &&
      length == null &&
      devStatus == null &&
      minRating == 7.0 &&
      minVotes == 50 &&
      !showExplicitContent &&
      tags.isEmpty;

  List<dynamic> buildApiFilters() {
    final filters = <dynamic>[];

    if (lang != null) {
      filters.add(['lang', '=', lang]);
    }

    if (platform != null) {
      filters.add(['platform', '=', platform]);
    }

    if (length != null) {
      filters.add(['length', '=', length]);
    }

    if (devStatus != null) {
      filters.add(['devstatus', '=', devStatus]);
    }

    // Always apply rating and votecount if set (or let it be dynamic)
    filters.add(['rating', '>=', (minRating * 10).round()]);
    filters.add(['votecount', '>=', minVotes]);

    for (final tag in tags) {
      filters.add(['tag', '=', tag.id]);
    }

    return filters;
  }
}

class VnFilterNotifier extends Notifier<VnFilterState> {
  @override
  VnFilterState build() {
    final settings = ref.watch(settingsProvider);

    return VnFilterState(
      lang: settings.defaultLanguage,
      platform: settings.defaultPlatform,
      showExplicitContent: settings.showExplicitContent,
    );
  }

  void update(VnFilterState value) => state = value;
}

final vnFilterProvider = NotifierProvider<VnFilterNotifier, VnFilterState>(
  VnFilterNotifier.new,
);

class VnSortState {
  final String field;
  final bool descending;

  const VnSortState({required this.field, this.descending = true});

  VnSortState copyWith({String? field, bool? descending}) {
    return VnSortState(
      field: field ?? this.field,
      descending: descending ?? this.descending,
    );
  }
}

class VnSortNotifier extends Notifier<VnSortState> {
  @override
  VnSortState build() {
    return const VnSortState(field: 'rating', descending: true);
  }

  void updateField(String field) {
    final bool defaultDesc = field != 'title' && field != 'id';

    state = VnSortState(field: field, descending: defaultDesc);
  }

  void toggleDirection() {
    state = state.copyWith(descending: !state.descending);
  }
}

final vnSortProvider = NotifierProvider<VnSortNotifier, VnSortState>(
  VnSortNotifier.new,
);

// State representation for visual novel list
class VnListState {
  final List<VisualNovel> vns;
  final bool isLoading;
  final bool isLoadMore;
  final bool hasMore;
  final String? errorMessage;
  final int page;

  VnListState({
    required this.vns,
    required this.isLoading,
    required this.isLoadMore,
    required this.hasMore,
    this.errorMessage,
    required this.page,
  });

  factory VnListState.initial() {
    return VnListState(
      vns: [],
      isLoading: false,
      isLoadMore: false,
      hasMore: true,
      page: 1,
    );
  }

  VnListState copyWith({
    List<VisualNovel>? vns,
    bool? isLoading,
    bool? isLoadMore,
    bool? hasMore,
    String? errorMessage,
    int? page,
  }) {
    return VnListState(
      vns: vns ?? this.vns,
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      page: page ?? this.page,
    );
  }
}

// Notifier for visual novel list (handles pagination, searching, and loading states)
class VnListNotifier extends Notifier<VnListState> {
  Timer? _debounceTimer;

  @override
  VnListState build() {
    // Initial fetch
    Future.microtask(() => fetchVns());

    // Listen to search query changes to reset list and refetch with debouncing
    ref.listen<String>(searchQueryProvider, (previous, next) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        resetAndFetch();
      });
    });

    // Listen to filter changes to reset list and refetch
    ref.listen<VnFilterState>(vnFilterProvider, (previous, next) {
      Future.microtask(() => resetAndFetch());
    });

    // Listen to sort changes to reset list and refetch
    ref.listen<VnSortState>(vnSortProvider, (previous, next) {
      Future.microtask(() => resetAndFetch());
    });

    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    // Prevent fetching if already loading or no more results
    if (state.isLoading || state.isLoadMore || !state.hasMore) {
      return;
    }

    final isInitial = state.vns.isEmpty;

    if (isInitial) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      state = state.copyWith(isLoadMore: true);
    }

    final query = ref.read(searchQueryProvider);
    final filtersState = ref.read(vnFilterProvider);
    final sortState = ref.read(vnSortProvider);
    final currentPage = state.page;
    final repository = ref.read(vnRepositoryProvider);

    try {
      final apiFilters = <dynamic>[];

      if (query.trim().isNotEmpty) {
        apiFilters.add(['search', '=', query]);
      }

      apiFilters.addAll(filtersState.buildApiFilters());

      final response = await repository.getVisualNovels(
        filters: apiFilters.length > 1
            ? ['and', ...apiFilters]
            : (apiFilters.isNotEmpty ? apiFilters.first : []),
        page: currentPage,
        sort: query.trim().isEmpty ? sortState.field : null,
        reverse: query.trim().isEmpty ? sortState.descending : true,
      );

      final List<VisualNovel> allVns = response['vns'] as List<VisualNovel>;
      final bool hasMore = response['hasMore'] as bool;

      final List<VisualNovel> newVns = filtersState.showExplicitContent
          ? allVns
          : allVns.where((vn) => (vn.imageSexual ?? 0.0) <= 0.2).toList();

      state = state.copyWith(
        vns: isInitial ? newVns : [...state.vns, ...newVns],
        isLoading: false,
        isLoadMore: false,
        hasMore: hasMore,
        page: currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> resetAndFetch() async {
    state = VnListState.initial();
    await fetchVns();
  }
}

// Provider for the paginated VN list state
final vnListProvider = NotifierProvider<VnListNotifier, VnListState>(
  VnListNotifier.new,
);

// Future Provider for single Visual Novel details
final vnDetailsProvider = FutureProvider.family<VisualNovel, String>((
  ref,
  id,
) async {
  final repository = ref.watch(vnRepositoryProvider);

  return repository.getVisualNovelDetails(id);
});

// Notifier for visual novel list filtered by a specific tag (paginated)
class VnListByTagNotifier extends Notifier<VnListState> {
  final String _tagId;

  VnListByTagNotifier(this._tagId);

  @override
  VnListState build() {
    Future.microtask(() => fetchVns());

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    if (state.isLoading || state.isLoadMore || !state.hasMore) {
      return;
    }

    final isInitial = state.vns.isEmpty;

    if (isInitial) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      state = state.copyWith(isLoadMore: true);
    }

    final currentPage = state.page;
    final repository = ref.read(vnRepositoryProvider);
    final settings = ref.read(settingsProvider);

    try {
      final response = await repository.getVisualNovelsByTag(
        tagId: _tagId,
        page: currentPage,
      );

      final List<VisualNovel> allVns = response['vns'] as List<VisualNovel>;
      final bool hasMore = response['hasMore'] as bool;

      final List<VisualNovel> newVns = settings.showExplicitContent
          ? allVns
          : allVns.where((vn) => (vn.imageSexual ?? 0.0) <= 0.2).toList();

      state = state.copyWith(
        vns: isInitial ? newVns : [...state.vns, ...newVns],
        isLoading: false,
        isLoadMore: false,
        hasMore: hasMore,
        page: currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> resetAndFetch() async {
    state = VnListState.initial();
    await fetchVns();
  }
}

final vnListByTagProvider = NotifierProvider.autoDispose
    .family<VnListByTagNotifier, VnListState, String>(VnListByTagNotifier.new);

class VnUlistState {
  final VnUlistEntry? entry;
  final bool isLoading;
  final String? errorMessage;

  const VnUlistState({this.entry, this.isLoading = false, this.errorMessage});

  VnUlistState copyWith({
    VnUlistEntry? Function()? entry,
    bool? isLoading,
    String? Function()? errorMessage,
  }) {
    return VnUlistState(
      entry: entry != null ? entry() : this.entry,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

class UserUlistState {
  final Map<String, VnUlistEntry> entries;
  final bool isLoading;
  final String? errorMessage;

  const UserUlistState({
    this.entries = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  UserUlistState copyWith({
    Map<String, VnUlistEntry>? entries,
    bool? isLoading,
    String? Function()? errorMessage,
  }) {
    return UserUlistState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

class UserUlistNotifier extends Notifier<UserUlistState> {
  @override
  UserUlistState build() {
    final auth = ref.watch(authProvider);

    if (auth.isAuthenticated) {
      Future.microtask(() async {
        await loadCachedUserList();
        fetchAllEntries();
      });
    }

    return const UserUlistState();
  }

  Future<void> loadCachedUserList() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final cachedEntries = prefs.getString('vndb_user_ulist_entries');

      if (cachedEntries != null) {
        final List<dynamic> decoded = jsonDecode(cachedEntries);

        final Map<String, VnUlistEntry> entriesMap = {
          for (final item in decoded)
            VnUlistEntry.fromJson(item).id: VnUlistEntry.fromJson(item),
        };

        state = state.copyWith(entries: entriesMap);
      }
    } catch (_) {}
  }

  Future<void> fetchAllEntries() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);

    final auth = ref.read(authProvider);

    if (!auth.isAuthenticated) {
      state = state.copyWith(isLoading: false);

      return;
    }

    final userId = auth.userId!;
    final repository = ref.read(vnRepositoryProvider);

    try {
      final list = <VnUlistEntry>[];
      int page = 1;
      bool hasMore = true;

      while (hasMore) {
        final data = await repository.getUserList(user: userId, page: page);

        final results = data['results'] as List? ?? [];

        for (final item in results) {
          list.add(VnUlistEntry.fromJson(item as Map<String, dynamic>));
        }

        hasMore = data['more'] as bool? ?? false;
        page++;
      }

      final Map<String, VnUlistEntry> entriesMap = {
        for (final entry in list) entry.id: entry,
      };
      final prefs = await SharedPreferences.getInstance();
      final String jsonStr = jsonEncode(list.map((e) => e.toJson()).toList());

      await prefs.setString('vndb_user_ulist_entries', jsonStr);

      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString(),
      );
    }
  }

  Future<void> syncUserListAndData() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);

    final auth = ref.read(authProvider);

    if (!auth.isAuthenticated) {
      state = state.copyWith(isLoading: false);

      return;
    }

    final userId = auth.userId!;
    final repository = ref.read(vnRepositoryProvider);

    try {
      final prefs = await SharedPreferences.getInstance();
      final labels = await repository.getUserListLabels();
      final String labelsJson = jsonEncode(
        labels.map((e) => e.toJson()).toList(),
      );

      await prefs.setString('vndb_user_ulist_labels', labelsJson);
      ref.invalidate(ulistLabelsProvider);

      final list = <VnUlistEntry>[];
      int page = 1;
      bool hasMore = true;

      while (hasMore) {
        final data = await repository.getUserList(user: userId, page: page);

        final results = data['results'] as List? ?? [];

        for (final item in results) {
          list.add(VnUlistEntry.fromJson(item as Map<String, dynamic>));
        }

        hasMore = data['more'] as bool? ?? false;
        page++;
      }

      final Map<String, VnUlistEntry> entriesMap = {
        for (final entry in list) entry.id: entry,
      };
      final String entriesJson = jsonEncode(
        list.map((e) => e.toJson()).toList(),
      );

      await prefs.setString('vndb_user_ulist_entries', entriesJson);

      await ref.read(localTagsProvider.notifier).fetchAndCacheAllTags();

      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString(),
      );

      rethrow;
    }
  }

  Future<void> updateVote(String vnId, int? voteScore) async {
    final oldEntries = state.entries;

    final currentEntry = oldEntries[vnId];

    final currentLabels = currentEntry?.labels ?? const [];

    final currentVn = currentEntry?.vn;

    final newEntry = VnUlistEntry(
      id: vnId,
      vote: voteScore,
      labels: currentLabels,
      vn: currentVn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vnId] = newEntry;
    state = state.copyWith(entries: updatedEntries);

    final repository = ref.read(vnRepositoryProvider);

    try {
      await repository.updateUserListEntry(
        vnId: vnId,
        vote: voteScore,
        updateVote: true,
      );
    } catch (e) {
      state = state.copyWith(
        entries: oldEntries,
        errorMessage: () => e.toString(),
      );
    }
  }

  Future<void> updateLabels(String vnId, List<int> labels) async {
    final oldEntries = state.entries;

    final currentEntry = oldEntries[vnId];

    final currentVote = currentEntry?.vote;

    final currentVn = currentEntry?.vn;

    final newEntry = VnUlistEntry(
      id: vnId,
      vote: currentVote,
      labels: labels,
      vn: currentVn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vnId] = newEntry;
    state = state.copyWith(entries: updatedEntries);

    final repository = ref.read(vnRepositoryProvider);

    try {
      await repository.updateUserListEntry(
        vnId: vnId,
        labels: labels,
        updateLabels: true,
      );
    } catch (e) {
      state = state.copyWith(
        entries: oldEntries,
        errorMessage: () => e.toString(),
      );
    }
  }
}

final userUlistProvider = NotifierProvider<UserUlistNotifier, UserUlistState>(
  UserUlistNotifier.new,
);

final vnUlistProvider = Provider.autoDispose.family<VnUlistState, String>((
  ref,
  vnId,
) {
  final ulistState = ref.watch(userUlistProvider);

  final entry = ulistState.entries[vnId];

  return VnUlistState(
    entry: entry,
    isLoading: ulistState.isLoading,
    errorMessage: ulistState.errorMessage,
  );
});

final ulistLabelsProvider = FutureProvider<List<VndbLabel>>((ref) async {
  final repository = ref.watch(vnRepositoryProvider);
  final auth = ref.watch(authProvider);

  if (!auth.isAuthenticated) {
    return const [];
  }

  try {
    final prefs = await SharedPreferences.getInstance();

    final cached = prefs.getString('vndb_user_ulist_labels');

    if (cached != null) {
      final List<dynamic> decoded = jsonDecode(cached);

      return decoded
          .map((e) => VndbLabel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  } catch (_) {}

  final list = await repository.getUserListLabels();

  try {
    final prefs = await SharedPreferences.getInstance();

    final String jsonStr = jsonEncode(list.map((e) => e.toJson()).toList());

    await prefs.setString('vndb_user_ulist_labels', jsonStr);
  } catch (_) {}

  return list;
});

class LocalTagsState {
  final List<VnTag> tags;
  final bool isLoading;
  final String? errorMessage;
  final double progress;

  const LocalTagsState({
    this.tags = const [],
    this.isLoading = false,
    this.errorMessage,
    this.progress = 0.0,
  });

  LocalTagsState copyWith({
    List<VnTag>? tags,
    bool? isLoading,
    String? Function()? errorMessage,
    double? progress,
  }) {
    return LocalTagsState(
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      progress: progress ?? this.progress,
    );
  }
}

class LocalTagsNotifier extends Notifier<LocalTagsState> {
  @override
  LocalTagsState build() {
    Future.microtask(() => loadLocalTags());

    return const LocalTagsState();
  }

  Future<void> loadLocalTags() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);

    try {
      final prefs = await SharedPreferences.getInstance();

      final content = prefs.getString('vndb_tags_cache');

      if (content != null) {
        final List<dynamic> jsonList = jsonDecode(content) as List;

        final List<VnTag> loadedTags = jsonList
            .map((e) => VnTag.fromJson(e as Map<String, dynamic>))
            .toList();

        state = state.copyWith(tags: loadedTags, isLoading: false);

        return;
      }
    } catch (e) {
      // fallback to api below
    }

    await fetchAndCacheAllTags();
  }

  Future<void> fetchAndCacheAllTags() async {
    state = state.copyWith(
      isLoading: true,
      progress: 0.0,
      errorMessage: () => null,
    );

    final repository = ref.read(vnRepositoryProvider);

    final List<VnTag> allTags = [];

    try {
      int page = 1;

      bool hasMore = true;

      while (hasMore) {
        final data = await repository.getTagsPage(page: page);

        final results = data['results'] as List? ?? [];

        for (final item in results) {
          allTags.add(VnTag.fromJson(item as Map<String, dynamic>));
        }

        hasMore = data['more'] as bool? ?? false;
        page++;

        // There are around 31 pages total
        final currentProgress = (page - 1) / 32.0;

        state = state.copyWith(
          progress: currentProgress > 1.0 ? 1.0 : currentProgress,
        );

        // Delay 50ms to prevent rate limits
        await Future.delayed(const Duration(milliseconds: 50));
      }

      final prefs = await SharedPreferences.getInstance();

      final String jsonStr = jsonEncode(
        allTags.map((e) => e.toJson()).toList(),
      );

      await prefs.setString('vndb_tags_cache', jsonStr);

      state = state.copyWith(tags: allTags, isLoading: false, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString(),
      );
    }
  }
}

final localTagsProvider = NotifierProvider<LocalTagsNotifier, LocalTagsState>(
  LocalTagsNotifier.new,
);
