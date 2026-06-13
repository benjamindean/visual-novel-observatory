import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/vndb_client.dart';
import '../repository/vn_repository.dart';
import '../../auth/providers/auth_provider.dart';

final vndbClientProvider = Provider<VndbClient>((ref) {
  final auth = ref.watch(authProvider);

  return VndbClient(token: auth.token);
});

final vnRepositoryProvider = Provider<VnRepository>((ref) {
  final client = ref.watch(vndbClientProvider);

  return VnRepository(client);
});
