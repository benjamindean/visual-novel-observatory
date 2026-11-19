import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/app_storage.dart';
import '../../settings/providers/settings_provider.dart';
import '../models/visual_novel.dart';
import 'vn_core_providers.dart';
import 'vn_list_providers.dart';
import '../../core/utils/error_utils.dart';

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
  int _requestGeneration = 0;

  @override
  VnListState build() {
    ref.listen<String>(searchScreenQueryProvider, (previous, next) {
      _requestGeneration++;
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        resetAndFetch();
      });
    });

    ref.listen<bool>(
      settingsProvider.select((settings) => settings.disableExplicitContent),
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

    final query = ref.read(searchScreenQueryProvider);

    if (query.trim().isEmpty) {
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
    final repository = ref.read(publicVnRepositoryProvider);
    final disableExplicitContent = ref.read(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );

    try {
      final response = await repository.searchVisualNovels(
        query: query,
        page: currentPage,
        disableExplicitContentFilter: disableExplicitContent,
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

final vnSearchProvider = NotifierProvider<VnSearchNotifier, VnListState>(
  VnSearchNotifier.new,
);

class RecentlyOpenedSearchNotifier extends Notifier<List<VisualNovel>> {
  static const String _key = 'recently_opened_search_vns';
  static const String _disableExplicitContentKey =
      'recently_opened_search_disable_explicit_content';

  @override
  List<VisualNovel> build() {
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );

    try {
      if (!_canUseCachedRecents(
        disableExplicitContent: disableExplicitContent,
      )) {
        return const [];
      }

      final box = AppStorage.mainBox;
      final String? jsonStr = box.get(_key) as String?;

      if (jsonStr != null) {
        final List<dynamic> jsonList = jsonDecode(jsonStr);

        return jsonList
            .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (error, stackTrace) {
      developer.log(
        'Failed to load recently opened search VNs.',
        name: 'RecentlyOpenedSearchNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return const [];
  }

  Future<void> addVn(VisualNovel vn) async {
    final disableExplicitContent = ref.read(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );
    final list = List<VisualNovel>.from(state);

    list.removeWhere((item) => item.id == vn.id);
    list.insert(0, vn);
    if (list.length > 20) {
      list.removeLast();
    }
    state = list;

    try {
      final box = AppStorage.mainBox;
      final String jsonStr = jsonEncode(list.map((e) => e.toJson()).toList());

      await box.put(_key, jsonStr);
      await box.put(_disableExplicitContentKey, disableExplicitContent);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to save recently opened search VNs.',
        name: 'RecentlyOpenedSearchNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> clear() async {
    state = const [];
    try {
      final box = AppStorage.mainBox;

      await box.delete(_key);
      await box.delete(_disableExplicitContentKey);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to clear recently opened search VNs.',
        name: 'RecentlyOpenedSearchNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool _canUseCachedRecents({
    required bool disableExplicitContent,
  }) {
    if (!disableExplicitContent) {
      return true;
    }

    return (AppStorage.mainBox.get(_disableExplicitContentKey) as bool?) ??
        false;
  }
}

final recentlyOpenedSearchProvider =
    NotifierProvider<RecentlyOpenedSearchNotifier, List<VisualNovel>>(
      RecentlyOpenedSearchNotifier.new,
    );
