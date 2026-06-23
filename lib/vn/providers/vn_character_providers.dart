import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vn_character.dart';
import 'vn_core_providers.dart';

final vnCharacterProvider = FutureProvider.family<VnCharacter, String>((
  ref,
  characterId,
) async {
  // Prevent synchronous state updates during widget build phase
  await Future.delayed(Duration.zero);
  final repository = ref.watch(vnRepositoryProvider);

  return repository.getCharacterDetails(characterId);
});
