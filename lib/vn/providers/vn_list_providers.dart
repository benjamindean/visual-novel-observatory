import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/visual_novel.dart';
import 'vn_core_providers.dart';
import 'vn_filter_providers.dart';
import '../../core/utils/error_utils.dart';
import '../../settings/providers/settings_provider.dart';

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

class VnListNotifier extends Notifier<VnListState> {
  Timer? _debounceTimer;
  int _requestGeneration = 0;

  @override
  VnListState build() {
    Future.microtask(() => fetchVns());

    ref.listen<String>(searchQueryProvider, (previous, next) {
      _requestGeneration++;
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        resetAndFetch();
      });
    });

    ref.listen<VnFilterState>(vnFilterProvider, (previous, next) {
      _requestGeneration++;
      Future.microtask(() => resetAndFetch());
    });

    ref.listen<VnSortState>(vnSortProvider, (previous, next) {
      _requestGeneration++;
      Future.microtask(() => resetAndFetch());
    });

    ref.listen<int>(
      settingsProvider.select((settings) => settings.spoilerLevel),
      (previous, next) {
        _requestGeneration++;
        Future.microtask(() => resetAndFetch());
      },
    );

    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    if (state.isLoading || state.isLoadMore || !state.hasMore) {
      return;
    }

    final requestGeneration = _requestGeneration;
    final isInitial = state.vns.isEmpty;

    if (isInitial) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      state = state.copyWith(isLoadMore: true);
    }

    final query = ref.read(searchQueryProvider);
    final filtersState = ref.read(vnFilterProvider);
    final spoilerLevel = ref.read(
      settingsProvider.select((settings) => settings.spoilerLevel),
    );
    final sortState = ref.read(vnSortProvider);
    final currentPage = state.page;
    final repository = ref.read(vnRepositoryProvider);

    try {
      final apiFilters = <dynamic>[];

      if (query.trim().isNotEmpty) {
        apiFilters.add(['search', '=', query]);
      }

      apiFilters.addAll(
        filtersState.buildApiFilters(spoilerLevel: spoilerLevel),
      );

      final response = await repository.getVisualNovels(
        filters: apiFilters.length > 1
            ? ['and', ...apiFilters]
            : (apiFilters.isNotEmpty ? apiFilters.first : []),
        page: currentPage,
        sort: query.trim().isEmpty ? sortState.field : null,
        reverse: query.trim().isEmpty ? sortState.descending : true,
      );

      if (requestGeneration != _requestGeneration) {
        return;
      }

      final List<VisualNovel> allVns = response['vns'] as List<VisualNovel>;
      final bool hasMore = response['hasMore'] as bool;

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

final vnListProvider = NotifierProvider<VnListNotifier, VnListState>(
  VnListNotifier.new,
);

class VnListByTagNotifier extends Notifier<VnListState> {
  final String _tagId;
  int _requestGeneration = 0;

  VnListByTagNotifier(this._tagId);

  @override
  VnListState build() {
    Future.microtask(() => fetchVns());

    ref.listen<int>(
      settingsProvider.select((settings) => settings.spoilerLevel),
      (previous, next) {
        _requestGeneration++;
        Future.microtask(() => resetAndFetch());
      },
    );

    return VnListState.initial();
  }

  Future<void> fetchVns() async {
    if (state.isLoading || state.isLoadMore || !state.hasMore) {
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

    try {
      final response = await repository.getVisualNovelsByTag(
        tagId: _tagId,
        spoilerLevel: spoilerLevel,
        page: currentPage,
      );

      if (requestGeneration != _requestGeneration) {
        return;
      }

      final List<VisualNovel> allVns = response['vns'] as List<VisualNovel>;
      final bool hasMore = response['hasMore'] as bool;

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

final vnListByTagProvider =
    NotifierProvider.family<VnListByTagNotifier, VnListState, String>(
      VnListByTagNotifier.new,
    );
