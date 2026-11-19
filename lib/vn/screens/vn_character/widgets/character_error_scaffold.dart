import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_voice_actor.dart';
import '../../../providers/vn_providers.dart';
import 'character_detail_avatar.dart';

class CharacterErrorScaffold extends ConsumerWidget {
  const CharacterErrorScaffold({
    super.key,
    required this.association,
    required this.error,
  });

  final VnVoiceActorAssociation association;
  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final character = association.character;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: context.appBackground,
            elevation: 0,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CharacterDetailAvatar(
                    imageUrl: character.imageUrl,
                    shouldBlur: false,
                    size: 116,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Could not load character details',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.appTextSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () {
                      ref.invalidate(
                        vnCharacterProvider(character.id),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
