import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vn_character.dart';
import 'vn_core_providers.dart';

final vnCharacterProvider = FutureProvider.family<VnCharacter, String>((
  ref,
  characterId,
) async {
  final repository = ref.read(publicVnRepositoryProvider);

  return repository.getCharacterDetails(characterId);
});
