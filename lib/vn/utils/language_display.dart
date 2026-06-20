import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import '../constants/vndb_languages.dart';

String languageDisplayName(BuildContext context, String language) {
  final vndbLanguage = vndbLanguageById(language);

  if (vndbLanguage != null) {
    return vndbLanguage.label;
  }

  final normalizedLanguage = _normalizeLocaleCode(language);
  final localizedName = LocaleNames.of(context)?.nameOf(normalizedLanguage);
  final nativeName =
      LocaleNamesLocalizationsDelegate.nativeLocaleNames[normalizedLanguage];

  return localizedName ?? nativeName ?? language.toUpperCase();
}

String _normalizeLocaleCode(String language) {
  final parts = language
      .replaceAll('-', '_')
      .split('_')
      .where((part) => part.isNotEmpty)
      .toList();

  if (parts.isEmpty) {
    return language;
  }

  final normalizedParts = <String>[
    parts.first.toLowerCase(),
  ];

  for (final part in parts.skip(1)) {
    if (part.length == 4) {
      normalizedParts.add(
        '${part.substring(0, 1).toUpperCase()}'
        '${part.substring(1).toLowerCase()}',
      );
      continue;
    }

    normalizedParts.add(part.toUpperCase());
  }

  return normalizedParts.join('_');
}
