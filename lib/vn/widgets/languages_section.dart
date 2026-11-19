import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';
import '../utils/language_display.dart';
import 'app_chip.dart';
import 'chip_overflow_wrap.dart';

class LanguagesSection extends StatelessWidget {
  final String? originalLanguage;
  final List<String> languages;

  const LanguagesSection({
    super.key,
    required this.originalLanguage,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    final originalCode = originalLanguage?.toLowerCase();
    final originalLabel = _languageLabel(context, originalLanguage);
    final availableLanguages = _availableLanguageLabels(context, originalCode);

    if (originalLabel == null && availableLanguages.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Languages',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ChipOverflowWrap(
          children: [
            if (originalLabel != null)
              AppChip(
                label: 'Original: $originalLabel',
                leadingIcon: Icons.translate_rounded,
                iconColor: context.colorScheme.tertiary,
              ),
            for (final language in availableLanguages)
              AppChip(
                label: language,
                leadingIcon: Icons.language_rounded,
              ),
          ],
        ),
      ],
    );
  }

  List<String> _availableLanguageLabels(
    BuildContext context,
    String? originalCode,
  ) {
    final seen = <String>{};
    final labels = <String>[];

    for (final language in languages) {
      final code = language.toLowerCase();

      if (code.isEmpty || code == originalCode || !seen.add(code)) {
        continue;
      }

      labels.add(languageDisplayName(context, language));
    }

    return labels;
  }

  String? _languageLabel(BuildContext context, String? language) {
    if (language == null || language.isEmpty) {
      return null;
    }

    return languageDisplayName(context, language);
  }
}
