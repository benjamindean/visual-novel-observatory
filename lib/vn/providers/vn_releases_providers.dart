import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vn_release.dart';
import 'vn_core_providers.dart';

class VnReleasesNotifier extends Notifier<AsyncValue<List<VnRelease>>> {
  VnReleasesNotifier(this.vnId);

  final String vnId;
  bool _hasLoaded = false;
  bool _isLoading = false;

  @override
  AsyncValue<List<VnRelease>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadReleases({bool forceRefresh = false}) async {
    if (_isLoading) {
      return;
    }

    if (_hasLoaded && !forceRefresh) {
      return;
    }

    _isLoading = true;

    if (forceRefresh || !_hasLoaded) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(vnRepositoryProvider);
      final releases = await repository.getReleases(vnId);

      _hasLoaded = true;
      state = AsyncValue.data(releases);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isLoading = false;
    }
  }
}

final vnReleasesProvider =
    NotifierProvider.family<
      VnReleasesNotifier,
      AsyncValue<List<VnRelease>>,
      String
    >(VnReleasesNotifier.new);
