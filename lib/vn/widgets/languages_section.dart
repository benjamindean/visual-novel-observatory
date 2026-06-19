import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
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

  static const _languageLabels = {
    'ar': 'Arabic',
    'bg': 'Bulgarian',
    'ca': 'Catalan',
    'cs': 'Czech',
    'da': 'Danish',
    'de': 'German',
    'el': 'Greek',
    'en': 'English',
    'eo': 'Esperanto',
    'es': 'Spanish',
    'eu': 'Basque',
    'fi': 'Finnish',
    'fr': 'French',
    'ga': 'Irish',
    'he': 'Hebrew',
    'hi': 'Hindi',
    'hr': 'Croatian',
    'hu': 'Hungarian',
    'id': 'Indonesian',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'lt': 'Lithuanian',
    'lv': 'Latvian',
    'ms': 'Malay',
    'nl': 'Dutch',
    'no': 'Norwegian',
    'pl': 'Polish',
    'pt-br': 'Portuguese (Brazil)',
    'pt-pt': 'Portuguese',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sk': 'Slovak',
    'sr': 'Serbian',
    'sv': 'Swedish',
    'ta': 'Tamil',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'vi': 'Vietnamese',
    'zh': 'Chinese',
    'zh-hans': 'Chinese (Simplified)',
    'zh-hant': 'Chinese (Traditional)',
  };

  @override
  Widget build(BuildContext context) {
    final originalCode = originalLanguage?.toLowerCase();
    final originalLabel = _languageLabel(originalLanguage);
    final availableLanguages = _availableLanguageLabels(originalCode);

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

  List<String> _availableLanguageLabels(String? originalCode) {
    final seen = <String>{};
    final labels = <String>[];

    for (final language in languages) {
      final code = language.toLowerCase();

      if (code.isEmpty || code == originalCode || !seen.add(code)) {
        continue;
      }

      labels.add(_languageLabels[code] ?? language.toUpperCase());
    }

    return labels;
  }

  String? _languageLabel(String? language) {
    if (language == null || language.isEmpty) {
      return null;
    }

    final code = language.toLowerCase();

    return _languageLabels[code] ?? language.toUpperCase();
  }
}
