import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/app_storage.dart';
import '../models/visual_novel.dart';
import '../models/vndb_label.dart';
import '../models/vn_ulist_entry.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';
import 'vn_core_providers.dart';
import 'vn_tags_providers.dart';
import '../../core/utils/error_utils.dart';

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

class UserUlistNotifier extends AsyncNotifier<UserUlistState> {
  static const String _libraryCacheDisableExplicitContentKey =
      'library_cache_disable_explicit_content';

  @override
  Future<UserUlistState> build() async {
    final disableExplicitContent = ref.watch(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );
    final auth = await ref.watch(authProvider.future);

    if (!auth.isAuthenticated) {
      return const UserUlistState();
    }

    return _syncUserListAndData(
      userId: auth.userId!,
      shouldFetchTags: true,
      disableExplicitContent: disableExplicitContent,
    );
  }

  Map<String, VnUlistEntry> _readCachedEntries({
    required bool disableExplicitContent,
  }) {
    try {
      if (!_canUseLibraryCache(
        disableExplicitContent: disableExplicitContent,
      )) {
        return const {};
      }

      final box = AppStorage.libraryBox;
      final cachedEntries = box.values.toList();

      return {
        for (final entry in cachedEntries) entry.id: entry,
      };
    } catch (error, stackTrace) {
      developer.log(
        'Failed to read cached user list.',
        name: 'UserUlistNotifier',
        error: error,
        stackTrace: stackTrace,
      );

      return const {};
    }
  }

  Future<void> fetchAllEntries() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final auth = await ref.read(authProvider.future);

      if (!auth.isAuthenticated) {
        return const UserUlistState();
      }
      final disableExplicitContent = ref.read(
        settingsProvider.select((settings) => settings.disableExplicitContent),
      );

      return _syncUserListAndData(
        userId: auth.userId!,
        shouldFetchTags: true,
        disableExplicitContent: disableExplicitContent,
      );
    });
  }

  Future<Map<String, VnUlistEntry>> _fetchEntriesForUser(
    String userId, {
    VnRepository? repository,
    required bool disableExplicitContent,
  }) async {
    final VnRepository activeRepository =
        repository ?? ref.read(vnRepositoryProvider);
    final list = <VnUlistEntry>[];

    int page = 1;
    bool hasMore = true;

    while (hasMore) {
      final data = await activeRepository.getUserList(
        user: userId,
        page: page,
        disableExplicitContentFilter: disableExplicitContent,
      );

      final results = data['results'] as List? ?? [];

      for (final item in results) {
        final entry = VnUlistEntry.fromJson(item as Map<String, dynamic>);

        list.add(entry);
      }

      hasMore = data['more'] as bool? ?? false;
      page++;
    }

    return {
      for (final entry in list) entry.id: entry,
    };
  }

  Future<void> syncUserListAndData({
    bool showLoading = true,
  }) async {
    if (showLoading) {
      state = const AsyncValue.loading();
    }

    state = await AsyncValue.guard(() async {
      final auth = await ref.read(authProvider.future);

      if (!auth.isAuthenticated) {
        return const UserUlistState();
      }
      final disableExplicitContent = ref.read(
        settingsProvider.select((settings) => settings.disableExplicitContent),
      );

      return _syncUserListAndData(
        userId: auth.userId!,
        shouldFetchTags: true,
        disableExplicitContent: disableExplicitContent,
      );
    });

    if (state.hasError) {
      throw state.error!;
    }

    final errorMessage = state.value?.errorMessage;

    if (errorMessage != null) {
      throw Exception(errorMessage);
    }
  }

  Future<UserUlistState> _syncUserListAndData({
    required String userId,
    required bool shouldFetchTags,
    required bool disableExplicitContent,
  }) async {
    final cachedEntries = _readCachedEntries(
      disableExplicitContent: disableExplicitContent,
    );
    final repository = ref.read(vnRepositoryProvider);

    try {
      final labels = await repository.getUserListLabels();

      if (!ref.mounted) {
        return UserUlistState(entries: cachedEntries);
      }

      if (!_isCurrentAuthenticatedUser(userId)) {
        return const UserUlistState();
      }

      final labelsBox = AppStorage.labelsBox;

      await labelsBox.clear();
      await labelsBox.putAll({
        for (final label in labels) label.id.toString(): label,
      });

      ref.invalidate(ulistLabelsProvider);

      final entriesMap = await _fetchEntriesForUser(
        userId,
        repository: repository,
        disableExplicitContent: disableExplicitContent,
      );

      if (!ref.mounted) {
        return UserUlistState(entries: cachedEntries);
      }

      if (!_isCurrentAuthenticatedUser(userId)) {
        return const UserUlistState();
      }

      await _saveEntriesToCache(
        entriesMap,
        disableExplicitContent: disableExplicitContent,
      );

      final tagsCache = AppStorage.mainBox.get('vndb_tags_cache') as String?;

      if (shouldFetchTags && (tagsCache == null || tagsCache.isEmpty)) {
        if (!ref.mounted) {
          return UserUlistState(entries: cachedEntries);
        }

        await ref.read(localTagsProvider.notifier).fetchAndCacheAllTags();
      }

      if (!ref.mounted) {
        return UserUlistState(entries: cachedEntries);
      }

      return UserUlistState(entries: entriesMap);
    } catch (e) {
      if (cachedEntries.isNotEmpty) {
        return UserUlistState(
          entries: cachedEntries,
          errorMessage: cleanErrorMessage(e),
        );
      }

      return UserUlistState(
        errorMessage: cleanErrorMessage(e),
      );
    }
  }

  bool _canUseLibraryCache({
    required bool disableExplicitContent,
  }) {
    if (!disableExplicitContent) {
      return true;
    }

    return (AppStorage.mainBox.get(_libraryCacheDisableExplicitContentKey)
            as bool?) ??
        false;
  }

  bool _isCurrentAuthenticatedUser(String userId) {
    final auth = ref.read(authProvider).value ?? const AuthState();

    return auth.isAuthenticated && auth.userId == userId;
  }

  Future<void> _saveEntriesToCache(
    Map<String, VnUlistEntry> entries, {
    required bool disableExplicitContent,
  }) async {
    try {
      final box = AppStorage.libraryBox;

      await box.clear();
      await box.putAll({for (final entry in entries.values) entry.id: entry});
      await AppStorage.mainBox.put(
        _libraryCacheDisableExplicitContentKey,
        disableExplicitContent,
      );
    } catch (error, stackTrace) {
      developer.log(
        'Failed to save user list cache.',
        name: 'UserUlistNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateVote(VisualNovel vn, int? voteScore) async {
    final currentState = state.value ?? const UserUlistState();
    final oldEntries = currentState.entries;
    final currentEntry = oldEntries[vn.id];
    final currentLabels = currentEntry?.labels ?? const [];
    final added = currentEntry?.added ?? _currentUnixTimestamp();
    final disableExplicitContent = ref.read(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );

    final newEntry = VnUlistEntry(
      id: vn.id,
      added: added,
      vote: voteScore,
      labels: currentLabels,
      vn: vn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vn.id] = newEntry;
    state = AsyncValue.data(currentState.copyWith(entries: updatedEntries));

    await _saveEntriesToCache(
      updatedEntries,
      disableExplicitContent: disableExplicitContent,
    );

    final repository = ref.read(vnRepositoryProvider);

    try {
      await repository.updateUserListEntry(
        vnId: vn.id,
        vote: voteScore,
        updateVote: true,
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(
          entries: oldEntries,
          errorMessage: () => cleanErrorMessage(e),
        ),
      );
      await _saveEntriesToCache(
        oldEntries,
        disableExplicitContent: disableExplicitContent,
      );
    }
  }

  Future<void> updateLabels(
    String vnId,
    List<int> labels, {
    VisualNovel? vn,
  }) async {
    final currentState = state.value ?? const UserUlistState();
    final oldEntries = currentState.entries;
    final currentEntry = oldEntries[vnId];
    final currentVote = currentEntry?.vote;
    final currentVn = vn ?? currentEntry?.vn;
    final added = currentEntry?.added ?? _currentUnixTimestamp();
    final disableExplicitContent = ref.read(
      settingsProvider.select((settings) => settings.disableExplicitContent),
    );

    final newEntry = VnUlistEntry(
      id: vnId,
      added: added,
      vote: currentVote,
      labels: labels,
      vn: currentVn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vnId] = newEntry;
    state = AsyncValue.data(currentState.copyWith(entries: updatedEntries));
    await _saveEntriesToCache(
      updatedEntries,
      disableExplicitContent: disableExplicitContent,
    );

    final repository = ref.read(vnRepositoryProvider);

    try {
      await repository.updateUserListEntry(
        vnId: vnId,
        labels: labels,
        updateLabels: true,
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(
          entries: oldEntries,
          errorMessage: () => cleanErrorMessage(e),
        ),
      );
      await _saveEntriesToCache(
        oldEntries,
        disableExplicitContent: disableExplicitContent,
      );
    }
  }
}

final userUlistProvider =
    AsyncNotifierProvider<UserUlistNotifier, UserUlistState>(
      UserUlistNotifier.new,
    );

final vnUlistProvider = Provider.autoDispose.family<VnUlistState, String>((
  ref,
  vnId,
) {
  final userListAsync = ref.watch(userUlistProvider);

  return userListAsync.when(
    data: (state) => VnUlistState(
      entry: state.entries[vnId],
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    ),
    loading: () => const VnUlistState(isLoading: true),
    error: (error, stackTrace) => VnUlistState(
      errorMessage: cleanErrorMessage(error),
    ),
  );
});

final userUlistIsLoadingProvider = Provider.autoDispose<bool>((ref) {
  final userListAsync = ref.watch(userUlistProvider);

  return userListAsync.when(
    data: (state) => state.isLoading,
    loading: () => true,
    error: (error, stackTrace) => false,
  );
});

final libraryVnsByLabelProvider = Provider.autoDispose
    .family<List<VisualNovel>, int>((ref, labelId) {
      final userListAsync = ref.watch(userUlistProvider);

      if (userListAsync.isLoading) {
        return const [];
      }

      final state = userListAsync.value;
      final entries = state?.entries ?? const <String, VnUlistEntry>{};

      final sortedEntries =
          entries.values
              .where((entry) => entry.labels.contains(labelId))
              .where((entry) => entry.vn != null)
              .toList()
            ..sort(_compareEntriesByAddedDescending);

      return sortedEntries.map((entry) => entry.vn!).toList();
    });

int _compareEntriesByAddedDescending(VnUlistEntry a, VnUlistEntry b) {
  return (b.added ?? 0).compareTo(a.added ?? 0);
}

int _currentUnixTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/
      Duration.millisecondsPerSecond;
}

final libraryVnCountByLabelProvider = Provider.autoDispose.family<int, int>((
  ref,
  labelId,
) {
  return ref.watch(
    libraryVnsByLabelProvider(labelId).select((vns) {
      return vns.length;
    }),
  );
});

final ulistLabelsProvider = Provider.autoDispose<List<VndbLabel>>((ref) {
  try {
    final box = AppStorage.labelsBox;

    return box.values.toList();
  } catch (error, stackTrace) {
    developer.log(
      'Failed to read cached ulist labels.',
      name: 'ulistLabelsProvider',
      error: error,
      stackTrace: stackTrace,
    );
  }

  return const [];
});
