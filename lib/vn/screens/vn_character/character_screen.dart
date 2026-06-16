import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/vn_voice_actor.dart';
import '../../models/vn_screenshot.dart';
import '../../widgets/spoiler_text.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';
import 'widgets/character_detail_avatar.dart';
import 'widgets/quick_stat_tile.dart';

class CharacterScreen extends ConsumerWidget {
  final VnVoiceActorAssociation association;

  const CharacterScreen({super.key, required this.association});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final char = association.character;
    final staff = association.staff;

    final shouldBlur =
        (!settings.showExplicitContent &&
            char.imageSexual != null &&
            char.imageSexual! > 0.2) ||
        (!settings.showViolentContent &&
            char.imageViolence != null &&
            char.imageViolence! > 0.2);

    final List<Map<String, String>> stats = [];

    if (char.formattedAge != null) {
      stats.add({'label': 'Age', 'value': char.formattedAge!});
    }

    if (char.formattedBloodType != null) {
      stats.add({'label': 'Blood Type', 'value': char.formattedBloodType!});
    }

    if (char.formattedHeight != null) {
      stats.add({'label': 'Height', 'value': char.formattedHeight!});
    }

    if (char.formattedWeight != null) {
      stats.add({'label': 'Weight', 'value': char.formattedWeight!});
    }

    if (char.formattedMeasurements != null) {
      stats.add({
        'label': 'Measurements',
        'value': char.formattedMeasurements!,
      });
    }

    final activeTraits = char.traits
        .where((t) => t.spoiler <= settings.spoilerLevel)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: context.appBackground,
            title: Text(
              char.name,
              style: TextStyle(
                color: context.appTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Character header: avatar + info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circle avatar, tappable to expand
                      GestureDetector(
                        onTap: char.imageUrl != null && !shouldBlur
                            ? () {
                                context.push(
                                  '/gallery',
                                  extra: {
                                    'screenshots': [
                                      VnScreenshot(
                                        url: char.imageUrl!,
                                        sexual: char.imageSexual,
                                        violence: char.imageViolence,
                                      ),
                                    ],
                                    'initialIndex': 0,
                                  },
                                );
                              }
                            : null,
                        child: CharacterDetailAvatar(
                          imageUrl: char.imageUrl,
                          shouldBlur: shouldBlur,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Name and quick stats
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (char.original != null &&
                                char.original!.isNotEmpty) ...[
                              Text(
                                char.original!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: context.appAccentTeal,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                            ],
                            if (char.formattedGender != null)
                              QuickStatTile(
                                icon: Icons.person_outline_rounded,
                                label: char.formattedGender!,
                              ),
                            if (char.formattedBirthday != null)
                              QuickStatTile(
                                icon: Icons.cake_outlined,
                                label: char.formattedBirthday!,
                              ),
                            if (staff != null)
                              QuickStatTile(
                                icon: Icons.mic_none_outlined,
                                label: staff.name,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Characteristics card
                  if (stats.isNotEmpty) ...[
                    Text(
                      'Characteristics',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: context.appSurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: stats.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final stat = entry.value;
                          final isLast = idx == stats.length - 1;

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 14.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      stat['label']!,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: context.appTextMuted,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      child: Text(
                                        stat['value']!,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: context.appTextPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: context.appTextPrimary.withValues(
                                    alpha: 0.05,
                                  ),
                                  indent: 16,
                                  endIndent: 16,
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Description
                  if (char.description != null &&
                      char.description!.isNotEmpty) ...[
                    Text(
                      'About',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SpoilerText(
                      text: char.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: context.appTextSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Traits
                  if (activeTraits.isNotEmpty) ...[
                    Text(
                      'Traits',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: activeTraits.map((trait) {
                        return Chip(
                          label: Text(trait.name),
                          backgroundColor: context.appSurface,
                          labelStyle: TextStyle(
                            color: context.appTextSecondary,
                            fontSize: 12,
                          ),
                          side: BorderSide(
                            color: context.appTextPrimary.withValues(
                              alpha: 0.05,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
