import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/app_storage.dart';
import '../models/visual_novel.dart';
import '../models/vndb_label.dart';
import '../models/vn_ulist_entry.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
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

class UserUlistNotifier extends Notifier<UserUlistState> {
  @override
  UserUlistState build() {
    return UserUlistState(entries: _readCachedEntries());
  }

  Map<String, VnUlistEntry> _readCachedEntries() {
    try {
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

  void clearLocalState() {
    state = const UserUlistState();
  }

  Future<void> fetchAllEntries() async {
    await _syncUserListAndData(
      shouldSetLoading: true,
      shouldRethrow: false,
    );
  }

  Future<Map<String, VnUlistEntry>> _fetchEntriesForUser(
    String userId, {
    VnRepository? repository,
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
      );

      final results = data['results'] as List? ?? [];

      for (final item in results) {
        list.add(VnUlistEntry.fromJson(item as Map<String, dynamic>));
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
    await _syncUserListAndData(
      shouldSetLoading: showLoading,
      shouldRethrow: true,
    );
  }

  Future<void> _syncUserListAndData({
    required bool shouldSetLoading,
    bool shouldRethrow = false,
  }) async {
    if (shouldSetLoading) {
      state = state.copyWith(isLoading: true, errorMessage: () => null);
    }

    final auth = ref.read(authProvider).value ?? const AuthState();

    if (!auth.isAuthenticated) {
      if (shouldSetLoading) {
        state = state.copyWith(isLoading: false);
      }

      return;
    }

    final userId = auth.userId!;
    final repository = ref.read(vnRepositoryProvider);

    try {
      final labels = await repository.getUserListLabels();

      if (!ref.mounted) {
        return;
      }

      if (!_isCurrentAuthenticatedUser(userId)) {
        return;
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
      );

      if (!ref.mounted) {
        return;
      }

      if (!_isCurrentAuthenticatedUser(userId)) {
        return;
      }

      await _saveEntriesToCache(entriesMap);

      final tagsCache = AppStorage.mainBox.get('vndb_tags_cache') as String?;

      if (tagsCache == null || tagsCache.isEmpty) {
        if (!ref.mounted) {
          return;
        }

        await ref.read(localTagsProvider.notifier).fetchAndCacheAllTags();
      }

      if (!ref.mounted) {
        return;
      }

      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      if (!ref.mounted) {
        return;
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: () => cleanErrorMessage(e),
      );

      if (shouldRethrow) {
        rethrow;
      }
    }
  }

  bool _isCurrentAuthenticatedUser(String userId) {
    final auth = ref.read(authProvider).value ?? const AuthState();

    return auth.isAuthenticated && auth.userId == userId;
  }

  Future<void> _saveEntriesToCache(Map<String, VnUlistEntry> entries) async {
    try {
      final box = AppStorage.libraryBox;

      await box.clear();
      await box.putAll({for (final entry in entries.values) entry.id: entry});
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
    final oldEntries = state.entries;
    final currentEntry = oldEntries[vn.id];
    final currentLabels = currentEntry?.labels ?? const [];
    final added = currentEntry?.added ?? _currentUnixTimestamp();

    final newEntry = VnUlistEntry(
      id: vn.id,
      added: added,
      vote: voteScore,
      labels: currentLabels,
      vn: vn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vn.id] = newEntry;
    state = state.copyWith(entries: updatedEntries);

    await _saveEntriesToCache(updatedEntries);

    final repository = ref.read(vnRepositoryProvider);

    try {
      await repository.updateUserListEntry(
        vnId: vn.id,
        vote: voteScore,
        updateVote: true,
      );
    } catch (e) {
      state = state.copyWith(
        entries: oldEntries,
        errorMessage: () => cleanErrorMessage(e),
      );
      await _saveEntriesToCache(oldEntries);
    }
  }

  Future<void> updateLabels(
    String vnId,
    List<int> labels, {
    VisualNovel? vn,
  }) async {
    final oldEntries = state.entries;
    final currentEntry = oldEntries[vnId];
    final currentVote = currentEntry?.vote;
    final currentVn = vn ?? currentEntry?.vn;
    final added = currentEntry?.added ?? _currentUnixTimestamp();

    final newEntry = VnUlistEntry(
      id: vnId,
      added: added,
      vote: currentVote,
      labels: labels,
      vn: currentVn,
    );

    final updatedEntries = Map<String, VnUlistEntry>.from(oldEntries);

    updatedEntries[vnId] = newEntry;
    state = state.copyWith(entries: updatedEntries);
    await _saveEntriesToCache(updatedEntries);

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
        errorMessage: () => cleanErrorMessage(e),
      );
      await _saveEntriesToCache(oldEntries);
    }
  }
}

final userUlistProvider =
    NotifierProvider.autoDispose<UserUlistNotifier, UserUlistState>(
      UserUlistNotifier.new,
    );

final vnUlistProvider = Provider.autoDispose.family<VnUlistState, String>((
  ref,
  vnId,
) {
  final entry = ref.watch(
    userUlistProvider.select((state) => state.entries[vnId]),
  );
  final isLoading = ref.watch(
    userUlistProvider.select((state) => state.isLoading),
  );
  final errorMessage = ref.watch(
    userUlistProvider.select((state) => state.errorMessage),
  );

  return VnUlistState(
    entry: entry,
    isLoading: isLoading,
    errorMessage: errorMessage,
  );
});

final userUlistIsLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(userUlistProvider.select((state) => state.isLoading));
});

final libraryVnsByLabelProvider = Provider.autoDispose
    .family<List<VisualNovel>, int>((ref, labelId) {
      final entries = ref.watch(
        userUlistProvider.select((state) => state.entries),
      );

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
