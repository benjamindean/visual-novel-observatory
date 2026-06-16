import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/vndb_client.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/visual_novel.dart';

final vndbClientProvider = Provider<VndbClient>((ref) {
  final auth = ref.watch(authProvider);

  return VndbClient(token: auth.token);
});

final vnRepositoryProvider = Provider<VnRepository>((ref) {
  final client = ref.watch(vndbClientProvider);

  return VnRepository(client);
});

final vnDetailProvider = FutureProvider.family<VisualNovel, String>((
  ref,
  vnId,
) async {
  final repository = ref.watch(vnRepositoryProvider);
  final response = await repository.getVisualNovels(
    filters: ['id', '=', vnId],
    page: 1,
    resultsPerPage: 1,
  );
  final vns = response['vns'] as List<VisualNovel>;

  if (vns.isEmpty) {
    throw Exception('Visual novel not found');
  }

  return vns.first;
});
