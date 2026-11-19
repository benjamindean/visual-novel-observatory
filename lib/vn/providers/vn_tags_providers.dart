import 'dart:convert';
import 'dart:async' show unawaited;
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/app_storage.dart';
import '../models/vn_tag.dart';
import 'vn_core_providers.dart';
import '../../core/utils/error_utils.dart';

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
    final cachedTags = _readCachedTags();

    if (cachedTags != null) {
      return LocalTagsState(tags: cachedTags);
    }

    unawaited(_fetchAndCacheAllTags(shouldSetLoading: false));

    return const LocalTagsState(isLoading: true);
  }

  Future<void> loadLocalTags() async {
    final cachedTags = _readCachedTags();

    if (cachedTags != null) {
      state = state.copyWith(tags: cachedTags, isLoading: false);

      return;
    }

    await fetchAndCacheAllTags();
  }

  List<VnTag>? _readCachedTags() {
    try {
      final box = AppStorage.mainBox;
      final content = box.get('vndb_tags_cache') as String?;

      if (content != null) {
        final List<dynamic> jsonList = jsonDecode(content) as List;
        final List<VnTag> loadedTags = jsonList
            .map((e) => VnTag.fromJson(e as Map<String, dynamic>))
            .toList();

        return loadedTags;
      }
    } catch (error, stackTrace) {
      developer.log(
        'Failed to load cached tags; falling back to API.',
        name: 'LocalTagsNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return null;
  }

  Future<void> fetchAndCacheAllTags() async {
    await _fetchAndCacheAllTags(shouldSetLoading: true);
  }

  Future<void> _fetchAndCacheAllTags({
    required bool shouldSetLoading,
  }) async {
    if (shouldSetLoading) {
      state = state.copyWith(
        isLoading: true,
        progress: 0.0,
        errorMessage: () => null,
      );
    }

    final repository = ref.read(publicVnRepositoryProvider);
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

      final box = AppStorage.mainBox;
      final String jsonStr = jsonEncode(
        allTags.map((e) => e.toJson()).toList(),
      );

      await box.put('vndb_tags_cache', jsonStr);

      state = state.copyWith(tags: allTags, isLoading: false, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => cleanErrorMessage(e),
      );
    }
  }
}

final localTagsProvider = NotifierProvider<LocalTagsNotifier, LocalTagsState>(
  LocalTagsNotifier.new,
);
