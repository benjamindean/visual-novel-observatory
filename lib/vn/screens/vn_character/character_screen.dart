import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/vn_voice_actor.dart';
import '../../providers/vn_providers.dart';
import 'widgets/character_detail_scaffold.dart';
import 'widgets/character_error_scaffold.dart';
import 'widgets/character_loading_scaffold.dart';

class CharacterScreen extends ConsumerWidget {
  final VnVoiceActorAssociation association;
  final String? vnId;

  const CharacterScreen({
    super.key,
    required this.association,
    this.vnId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterAsync = ref.watch(
      vnCharacterProvider(association.character.id),
    );

    return characterAsync.when(
      data: (character) {
        return CharacterDetailScaffold(
          character: character,
          staff: association.staff,
          vnId: vnId,
        );
      },
      loading: () {
        return CharacterLoadingScaffold(association: association);
      },
      error: (error, stackTrace) {
        return CharacterErrorScaffold(
          association: association,
          error: error,
        );
      },
    );
  }
}
