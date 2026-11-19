import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import 'character_fact.dart';

class CharacterFactTile extends StatelessWidget {
  const CharacterFactTile({
    super.key,
    required this.fact,
  });

  final CharacterFact fact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: context.appSurface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              fact.icon,
              size: 18,
              color: context.appAccentTeal,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fact.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: context.appTextMuted,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fact.value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
