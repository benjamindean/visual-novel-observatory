import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_character.dart';
import '../../../widgets/app_chip.dart';

class CharacterTraitsSection extends StatelessWidget {
  const CharacterTraitsSection({
    super.key,
    required this.traits,
  });

  final List<VnCharacterTrait> traits;

  @override
  Widget build(BuildContext context) {
    if (traits.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Traits',
          style: theme.textTheme.titleMedium?.copyWith(
            color: context.appTextPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: traits.map((trait) {
            return AppChip(label: trait.name);
          }).toList(),
        ),
      ],
    );
  }
}
