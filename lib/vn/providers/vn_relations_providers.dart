import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'vn_core_providers.dart';
import '../models/vn_relation.dart';

final vnRelationsProvider = FutureProvider.family<List<VnRelation>, String>(
  (ref, vnId) async {
    final repository = ref.watch(vnRepositoryProvider);

    return repository.getRelations(vnId);
  },
);
