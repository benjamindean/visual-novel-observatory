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
      final box = AppStorage.libraryBox;
      final cachedEntries = box.values.toList();

      if (cachedEntries.isNotEmpty) {
        final Map<String, VnUlistEntry> entriesMap = {
          for (final entry in cachedEntries) entry.id: entry,
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
      await _saveEntriesToCache(entriesMap);

      state = state.copyWith(entries: entriesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => cleanErrorMessage(e),
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
      final labels = await repository.getUserListLabels();
      final labelsBox = AppStorage.labelsBox;

      await labelsBox.clear();
      await labelsBox.putAll({
        for (final label in labels) label.id.toString(): label,
      });
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
      await _saveEntriesToCache(entriesMap);

      await ref.read(localTagsProvider.notifier).fetchAndCacheAllTags();

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
    } catch (_) {}
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
    final box = AppStorage.labelsBox;
    final cached = box.values.toList();

    if (cached.isNotEmpty) {
      return cached;
    }
  } catch (_) {}

  final list = await repository.getUserListLabels();

  try {
    final box = AppStorage.labelsBox;

    await box.clear();
    await box.putAll({for (final label in list) label.id.toString(): label});
  } catch (_) {}

  return list;
});
