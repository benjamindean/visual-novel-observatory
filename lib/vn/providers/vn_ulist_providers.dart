import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/app_storage.dart';
import '../models/visual_novel.dart';
import '../models/vndb_label.dart';
import '../models/vn_ulist_entry.dart';
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
  String? _activeUserId;
  String? _loadedUserId;
  String? _loadingUserId;

  @override
  UserUlistState build() {
    final auth = ref.watch(
      authProvider.select(
        (auth) => (
          isAuthenticated: auth.isAuthenticated,
          userId: auth.userId,
        ),
      ),
    );

    if (!auth.isAuthenticated || auth.userId == null) {
      _activeUserId = null;
      _loadedUserId = null;
      _loadingUserId = null;

      return const UserUlistState();
    }

    if (_activeUserId != auth.userId) {
      _activeUserId = auth.userId;
      _loadedUserId = null;
      _loadingUserId = null;
    }

    return UserUlistState(entries: _readCachedEntries());
  }

  Future<void> loadCachedUserList() async {
    try {
      final entriesMap = _readCachedEntries();

      if (entriesMap.isNotEmpty) {
        state = state.copyWith(entries: entriesMap);
      }
    } catch (error, stackTrace) {
      developer.log(
        'Failed to load cached user list.',
        name: 'UserUlistNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }
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

  Future<void> ensureEntriesLoaded() async {
    await _fetchEntriesForCurrentUser(forceRefresh: false);
  }

  Future<void> fetchAllEntries() async {
    await _fetchEntriesForCurrentUser(forceRefresh: true);
  }

  Future<void> _fetchEntriesForCurrentUser({
    required bool forceRefresh,
  }) async {
    final auth = ref.read(authProvider);

    if (!auth.isAuthenticated) {
      state = state.copyWith(isLoading: false);

      return;
    }

    final userId = auth.userId!;

    if (_loadingUserId == userId) {
      return;
    }

    if (!forceRefresh && _loadedUserId == userId) {
      return;
    }

    _loadingUserId = userId;
    state = state.copyWith(isLoading: true, errorMessage: () => null);

    try {
      final entriesMap = await _fetchEntriesForUser(userId);
      final latestAuth = ref.read(authProvider);

      if (latestAuth.userId != userId) {
        return;
      }

      await _saveEntriesToCache(entriesMap);

      _loadedUserId = userId;
      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => cleanErrorMessage(e),
      );
    } finally {
      if (_loadingUserId == userId) {
        _loadingUserId = null;
      }
    }
  }

  Future<Map<String, VnUlistEntry>> _fetchEntriesForUser(String userId) async {
    final repository = ref.read(vnRepositoryProvider);
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

    return {
      for (final entry in list) entry.id: entry,
    };
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
      final labels = await repository.getUserListLabels();
      final labelsBox = AppStorage.labelsBox;

      await labelsBox.clear();
      await labelsBox.putAll({
        for (final label in labels) label.id.toString(): label,
      });

      ref.read(ulistLabelsProvider.notifier).setLabels(labels);

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

      await _saveEntriesToCache(entriesMap);

      final tagsCache = AppStorage.mainBox.get('vndb_tags_cache') as String?;

      if (tagsCache == null || tagsCache.isEmpty) {
        await ref.read(localTagsProvider.notifier).fetchAndCacheAllTags();
      }

      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => cleanErrorMessage(e),
      );

      rethrow;
    }
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

    final newEntry = VnUlistEntry(
      id: vn.id,
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

    final newEntry = VnUlistEntry(
      id: vnId,
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

final userUlistProvider = NotifierProvider<UserUlistNotifier, UserUlistState>(
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

final userUlistIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(userUlistProvider.select((state) => state.isLoading));
});

final libraryVnsByLabelProvider = Provider.autoDispose
    .family<List<VisualNovel>, int>((ref, labelId) {
      final entries = ref.watch(
        userUlistProvider.select((state) => state.entries),
      );

      return entries.values
          .where((entry) => entry.labels.contains(labelId))
          .where((entry) => entry.vn != null)
          .map((entry) => entry.vn!)
          .toList();
    });

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

class UlistLabelsNotifier extends Notifier<AsyncValue<List<VndbLabel>>> {
  String? _activeUserId;
  String? _loadedUserId;
  String? _loadingUserId;

  @override
  AsyncValue<List<VndbLabel>> build() {
    final auth = ref.watch(
      authProvider.select(
        (auth) => (
          isAuthenticated: auth.isAuthenticated,
          userId: auth.userId,
        ),
      ),
    );

    if (!auth.isAuthenticated || auth.userId == null) {
      _activeUserId = null;
      _loadedUserId = null;
      _loadingUserId = null;

      return const AsyncValue.data([]);
    }

    if (_activeUserId != auth.userId) {
      _activeUserId = auth.userId;
      _loadedUserId = null;
      _loadingUserId = null;
    }

    final cached = _readCachedLabels();

    if (cached.isEmpty) {
      return const AsyncValue.loading();
    }

    return AsyncValue.data(cached);
  }

  Future<void> loadLabels({bool forceRefresh = false}) async {
    final auth = ref.read(authProvider);

    if (!auth.isAuthenticated || auth.userId == null) {
      state = const AsyncValue.data([]);

      return;
    }

    final userId = auth.userId!;

    if (_loadingUserId == userId) {
      return;
    }

    if (!forceRefresh && _loadedUserId == userId) {
      return;
    }

    final currentLabels = state.value ?? const <VndbLabel>[];

    _loadingUserId = userId;

    if (currentLabels.isEmpty) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(vnRepositoryProvider);
      final labels = await repository.getUserListLabels();
      final latestAuth = ref.read(authProvider);

      if (latestAuth.userId != userId) {
        return;
      }

      await _saveLabelsToCache(labels);

      _loadedUserId = userId;
      state = AsyncValue.data(labels);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } finally {
      if (_loadingUserId == userId) {
        _loadingUserId = null;
      }
    }
  }

  void setLabels(List<VndbLabel> labels) {
    _loadedUserId = ref.read(authProvider).userId;
    state = AsyncValue.data(labels);
  }

  List<VndbLabel> _readCachedLabels() {
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

      return const [];
    }
  }

  Future<void> _saveLabelsToCache(List<VndbLabel> labels) async {
    try {
      final box = AppStorage.labelsBox;

      await box.clear();
      await box.putAll({
        for (final label in labels) label.id.toString(): label,
      });
    } catch (error, stackTrace) {
      developer.log(
        'Failed to save cached ulist labels.',
        name: 'ulistLabelsProvider',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final ulistLabelsProvider =
    NotifierProvider<UlistLabelsNotifier, AsyncValue<List<VndbLabel>>>(
      UlistLabelsNotifier.new,
    );
