import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vn_character.dart';
import '../../../models/vn_screenshot.dart';
import 'character_detail_avatar.dart';

class CharacterHeaderSection extends StatelessWidget {
  const CharacterHeaderSection({
    super.key,
    required this.character,
    required this.shouldBlur,
  });

  final VnCharacter character;
  final bool shouldBlur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: character.imageUrl != null && !shouldBlur
              ? () => _openImage(context)
              : null,
          child: CharacterDetailAvatar(
            imageUrl: character.imageUrl,
            shouldBlur: shouldBlur,
            size: 128,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: context.appTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (character.original != null &&
                  character.original!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  character.original!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.appAccentTeal,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _openImage(BuildContext context) {
    context.push(
      '/gallery',
      extra: {
        'screenshots': [
          VnScreenshot(
            url: character.imageUrl!,
            sexual: character.imageSexual,
            violence: character.imageViolence,
          ),
        ],
        'initialIndex': 0,
      },
    );
  }
}
