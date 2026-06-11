import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/vndb_client.dart';
import '../models/visual_novel.dart';
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

class VnFilterState {
  final String? lang;
  final String? platform;
  final int? length;
  final int? devStatus;
  final double minRating; // 0.0 to 10.0
  final int minVotes;
  final bool showExplicitContent;

  VnFilterState({
    this.lang,
    this.platform,
    this.length,
    this.devStatus,
    this.minRating = 7.0,
    this.minVotes = 50,
    this.showExplicitContent = false,
  });

  VnFilterState copyWith({
    String? Function()? lang,
    String? Function()? platform,
    int? Function()? length,
    int? Function()? devStatus,
    double? minRating,
    int? minVotes,
    bool? showExplicitContent,
  }) {
    return VnFilterState(
      lang: lang != null ? lang() : this.lang,
      platform: platform != null ? platform() : this.platform,
      length: length != null ? length() : this.length,
      devStatus: devStatus != null ? devStatus() : this.devStatus,
      minRating: minRating ?? this.minRating,
      minVotes: minVotes ?? this.minVotes,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
    );
  }

  bool get isEmpty =>
      lang == null &&
      platform == null &&
      length == null &&
      devStatus == null &&
      minRating == 7.0 &&
      minVotes == 50 &&
      !showExplicitContent;

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
      resetAndFetch();
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
        sort: query.trim().isEmpty ? 'rating' : null,
        reverse: query.trim().isEmpty,
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
