import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/vndb_client.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../models/visual_novel.dart';

final publicVndbClientProvider = Provider<VndbClient>((ref) {
  return VndbClient();
});

final publicVnRepositoryProvider = Provider<VnRepository>((ref) {
  final client = ref.read(publicVndbClientProvider);

  return VnRepository(client);
});

final vndbClientProvider = Provider<VndbClient>((ref) {
  final token = ref.watch(authProvider.select((auth) => auth.value?.token));

  return VndbClient(token: token);
});

final vnRepositoryProvider = Provider<VnRepository>((ref) {
  final client = ref.watch(vndbClientProvider);

  return VnRepository(client);
});

final vnDetailProvider = FutureProvider.family<VisualNovel, String>((
  ref,
  vnId,
) async {
  final repository = ref.read(publicVnRepositoryProvider);
  final disableExplicitContent = ref.watch(
    settingsProvider.select((settings) => settings.disableExplicitContent),
  );

  return repository.getVisualNovelDetails(
    vnId,
    disableExplicitContentFilter: disableExplicitContent,
  );
});
