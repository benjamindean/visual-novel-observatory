import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_voice_actor.dart';
import 'character_detail_avatar.dart';

class CharacterLoadingScaffold extends StatelessWidget {
  const CharacterLoadingScaffold({
    super.key,
    required this.association,
  });

  final VnVoiceActorAssociation association;

  @override
  Widget build(BuildContext context) {
    final character = association.character;
    final theme = Theme.of(context);

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
                    character.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: context.appAccentTeal,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Loading character details',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextSecondary,
                      fontWeight: FontWeight.w600,
                    ),
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
