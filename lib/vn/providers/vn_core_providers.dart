import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/vndb_client.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/visual_novel.dart';

final vndbClientProvider = Provider<VndbClient>((ref) {
  final token = ref.watch(authProvider.select((auth) => auth.token));

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
  // Prevent synchronous state updates during widget build phase
  await Future.delayed(Duration.zero);
  final repository = ref.watch(vnRepositoryProvider);

  return repository.getVisualNovelDetails(vnId);
});
