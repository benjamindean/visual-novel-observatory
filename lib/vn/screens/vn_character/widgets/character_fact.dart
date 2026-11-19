import 'package:material_ui/material_ui.dart';

import '../../../models/vn_character.dart';
import '../../../models/vn_staff.dart';

class CharacterFact {
  const CharacterFact({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  static List<CharacterFact> fromCharacter({
    required VnCharacter character,
    required VnStaff? staff,
    required String? vnId,
  }) {
    final facts = <CharacterFact>[];
    final role = character.roleLabelForVn(vnId);

    if (role != null) {
      facts.add(
        CharacterFact(
          icon: Icons.star_outline_rounded,
          label: 'Role',
          value: role,
        ),
      );
    }

    if (character.formattedGender != null) {
      facts.add(
        CharacterFact(
          icon: Icons.person_outline_rounded,
          label: 'Gender',
          value: character.formattedGender!,
        ),
      );
    }

    if (character.formattedAge != null) {
      facts.add(
        CharacterFact(
          icon: Icons.hourglass_empty_rounded,
          label: 'Age',
          value: character.formattedAge!,
        ),
      );
    }

    if (character.formattedBirthday != null) {
      facts.add(
        CharacterFact(
          icon: Icons.cake_outlined,
          label: 'Birthday',
          value: character.formattedBirthday!,
        ),
      );
    }

    if (character.formattedBloodType != null) {
      facts.add(
        CharacterFact(
          icon: Icons.bloodtype_outlined,
          label: 'Blood',
          value: character.formattedBloodType!,
        ),
      );
    }

    if (character.formattedHeight != null) {
      facts.add(
        CharacterFact(
          icon: Icons.height_rounded,
          label: 'Height',
          value: character.formattedHeight!,
        ),
      );
    }

    if (character.formattedWeight != null) {
      facts.add(
        CharacterFact(
          icon: Icons.monitor_weight_outlined,
          label: 'Weight',
          value: character.formattedWeight!,
        ),
      );
    }

    if (character.formattedMeasurements != null) {
      facts.add(
        CharacterFact(
          icon: Icons.straighten_rounded,
          label: 'Measurements',
          value: character.formattedMeasurements!,
        ),
      );
    }

    if (staff != null) {
      facts.add(
        CharacterFact(
          icon: Icons.mic_none_outlined,
          label: 'Voice',
          value: staff.name,
        ),
      );
    }

    return facts;
  }
}
