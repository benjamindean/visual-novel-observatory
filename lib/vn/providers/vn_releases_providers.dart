import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vn_release.dart';
import 'vn_core_providers.dart';

final vnReleasesProvider = FutureProvider.family<List<VnRelease>, String>((
  ref,
  vnId,
) async {
  final repository = ref.watch(vnRepositoryProvider);

  return repository.getReleases(vnId);
});
