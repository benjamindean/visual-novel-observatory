import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/providers/settings_provider.dart';
import '../../../../theme/app_theme.dart';
import '../../../models/vn_character.dart';
import '../../../models/vn_staff.dart';
import 'character_about_section.dart';
import 'character_fact.dart';
import 'character_fact_grid.dart';
import 'character_header_section.dart';
import 'character_traits_section.dart';

class CharacterDetailScaffold extends ConsumerWidget {
  const CharacterDetailScaffold({
    super.key,
    required this.character,
    required this.staff,
    required this.vnId,
  });

  final VnCharacter character;
  final VnStaff? staff;
  final String? vnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
          spoilerLevel: settings.spoilerLevel,
        ),
      ),
    );
    final shouldBlur =
        (!contentSettings.showExplicitContent &&
            character.imageSexual != null &&
            character.imageSexual! > 0.2) ||
        (!contentSettings.showViolentContent &&
            character.imageViolence != null &&
            character.imageViolence! > 0.2);
    final facts = CharacterFact.fromCharacter(
      character: character,
      staff: staff,
      vnId: vnId,
    );
    final activeTraits = character.traits
        .where((trait) => trait.spoiler <= contentSettings.spoilerLevel)
        .toList();
    final description = character.description ?? '';

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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterHeaderSection(
                    character: character,
                    shouldBlur: shouldBlur,
                  ),
                  if (facts.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    CharacterFactGrid(facts: facts),
                  ],
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    CharacterAboutSection(description: description),
                  ],
                  if (activeTraits.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    CharacterTraitsSection(traits: activeTraits),
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
