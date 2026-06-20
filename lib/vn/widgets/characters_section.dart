import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/vn_character.dart';
import '../models/vn_voice_actor.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';
import 'character_avatar.dart';

class CharactersSection extends ConsumerWidget {
  final List<VnVoiceActorAssociation> voiceActors;
  final String? vnId;

  const CharactersSection({
    super.key,
    required this.voiceActors,
    this.vnId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (voiceActors.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
        ),
      ),
    );
    final displayedActors = _sortedByRole(_dedupeByCharacter(voiceActors));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Characters',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            physics: const BouncingScrollPhysics(),
            itemCount: displayedActors.length,
            itemBuilder: (context, index) {
              final association = displayedActors[index];
              final char = association.character;
              final shouldBlur =
                  (!contentSettings.showExplicitContent &&
                      char.imageSexual != null &&
                      char.imageSexual! > 0.2) ||
                  (!contentSettings.showViolentContent &&
                      char.imageViolence != null &&
                      char.imageViolence! > 0.2);

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      '/character',
                      extra: {
                        'association': association,
                        'vnId': vnId,
                      },
                    );
                  },
                  child: SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        CharacterAvatar(
                          imageUrl: char.imageUrl,
                          shouldBlur: shouldBlur,
                          size: 72,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          char.name,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<VnVoiceActorAssociation> _dedupeByCharacter(
    List<VnVoiceActorAssociation> associations,
  ) {
    final seen = <String>{};
    final result = <VnVoiceActorAssociation>[];

    for (final association in associations) {
      if (seen.add(association.character.id)) {
        result.add(association);
      }
    }

    return result;
  }

  List<VnVoiceActorAssociation> _sortedByRole(
    List<VnVoiceActorAssociation> associations,
  ) {
    final sorted = [...associations];

    sorted.sort((a, b) {
      final firstRole = a.character.roleForVn(vnId);
      final secondRole = b.character.roleForVn(vnId);
      final roleComparison = VnCharacterVn.roleSortRank(
        firstRole,
      ).compareTo(VnCharacterVn.roleSortRank(secondRole));

      if (roleComparison != 0) {
        return roleComparison;
      }

      return a.character.name.compareTo(b.character.name);
    });

    return sorted;
  }
}
