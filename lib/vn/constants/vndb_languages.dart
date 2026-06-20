class VndbLanguage {
  const VndbLanguage({
    required this.id,
    required this.label,
    required this.flag,
  });

  final String id;
  final String label;
  final String flag;
}

const vndbLanguages = [
  VndbLanguage(id: 'ar', label: 'Arabic', flag: '🇸🇦'),
  VndbLanguage(id: 'eu', label: 'Basque', flag: '🇪🇸'),
  VndbLanguage(id: 'be', label: 'Belarusian', flag: '🇧🇾'),
  VndbLanguage(id: 'bg', label: 'Bulgarian', flag: '🇧🇬'),
  VndbLanguage(id: 'bs', label: 'Bosnian', flag: '🇧🇦'),
  VndbLanguage(id: 'ca', label: 'Catalan', flag: '🇪🇸'),
  VndbLanguage(id: 'ck', label: 'Cherokee', flag: '🇺🇸'),
  VndbLanguage(id: 'zh', label: 'Chinese', flag: '🇨🇳'),
  VndbLanguage(id: 'zh-Hans', label: 'Chinese (simplified)', flag: '🇨🇳'),
  VndbLanguage(id: 'zh-Hant', label: 'Chinese (traditional)', flag: '🇹🇼'),
  VndbLanguage(id: 'hr', label: 'Croatian', flag: '🇭🇷'),
  VndbLanguage(id: 'cs', label: 'Czech', flag: '🇨🇿'),
  VndbLanguage(id: 'da', label: 'Danish', flag: '🇩🇰'),
  VndbLanguage(id: 'nl', label: 'Dutch', flag: '🇳🇱'),
  VndbLanguage(id: 'en', label: 'English', flag: '🇬🇧'),
  VndbLanguage(id: 'eo', label: 'Esperanto', flag: '🌐'),
  VndbLanguage(id: 'et', label: 'Estonian', flag: '🇪🇪'),
  VndbLanguage(id: 'fi', label: 'Finnish', flag: '🇫🇮'),
  VndbLanguage(id: 'fr', label: 'French', flag: '🇫🇷'),
  VndbLanguage(id: 'gl', label: 'Galician', flag: '🇪🇸'),
  VndbLanguage(id: 'de', label: 'German', flag: '🇩🇪'),
  VndbLanguage(id: 'el', label: 'Greek', flag: '🇬🇷'),
  VndbLanguage(id: 'he', label: 'Hebrew', flag: '🇮🇱'),
  VndbLanguage(id: 'hi', label: 'Hindi', flag: '🇮🇳'),
  VndbLanguage(id: 'hu', label: 'Hungarian', flag: '🇭🇺'),
  VndbLanguage(id: 'ga', label: 'Irish', flag: '🇮🇪'),
  VndbLanguage(id: 'id', label: 'Indonesian', flag: '🇮🇩'),
  VndbLanguage(id: 'it', label: 'Italian', flag: '🇮🇹'),
  VndbLanguage(id: 'iu', label: 'Inuktitut', flag: '🇨🇦'),
  VndbLanguage(id: 'ja', label: 'Japanese', flag: '🇯🇵'),
  VndbLanguage(id: 'kk', label: 'Kazakh', flag: '🇰🇿'),
  VndbLanguage(id: 'ko', label: 'Korean', flag: '🇰🇷'),
  VndbLanguage(id: 'la', label: 'Latin', flag: '🇻🇦'),
  VndbLanguage(id: 'lv', label: 'Latvian', flag: '🇱🇻'),
  VndbLanguage(id: 'lt', label: 'Lithuanian', flag: '🇱🇹'),
  VndbLanguage(id: 'mk', label: 'Macedonian', flag: '🇲🇰'),
  VndbLanguage(id: 'ms', label: 'Malay', flag: '🇲🇾'),
  VndbLanguage(id: 'ne', label: 'Nepali', flag: '🇳🇵'),
  VndbLanguage(id: 'no', label: 'Norwegian', flag: '🇳🇴'),
  VndbLanguage(id: 'fa', label: 'Persian', flag: '🇮🇷'),
  VndbLanguage(id: 'pl', label: 'Polish', flag: '🇵🇱'),
  VndbLanguage(id: 'pt-br', label: 'Portuguese (Brazil)', flag: '🇧🇷'),
  VndbLanguage(id: 'pt-pt', label: 'Portuguese (Portugal)', flag: '🇵🇹'),
  VndbLanguage(id: 'ro', label: 'Romanian', flag: '🇷🇴'),
  VndbLanguage(id: 'ru', label: 'Russian', flag: '🇷🇺'),
  VndbLanguage(id: 'gd', label: 'Scottish Gaelic', flag: '🇬🇧'),
  VndbLanguage(id: 'sr', label: 'Serbian', flag: '🇷🇸'),
  VndbLanguage(id: 'sk', label: 'Slovak', flag: '🇸🇰'),
  VndbLanguage(id: 'sl', label: 'Slovene', flag: '🇸🇮'),
  VndbLanguage(id: 'es', label: 'Spanish', flag: '🇪🇸'),
  VndbLanguage(id: 'sv', label: 'Swedish', flag: '🇸🇪'),
  VndbLanguage(id: 'ta', label: 'Tagalog', flag: '🇵🇭'),
  VndbLanguage(id: 'th', label: 'Thai', flag: '🇹🇭'),
  VndbLanguage(id: 'tr', label: 'Turkish', flag: '🇹🇷'),
  VndbLanguage(id: 'uk', label: 'Ukrainian', flag: '🇺🇦'),
  VndbLanguage(id: 'ur', label: 'Urdu', flag: '🇵🇰'),
  VndbLanguage(id: 'vi', label: 'Vietnamese', flag: '🇻🇳'),
];

Map<String, String> get vndbLanguageLabels {
  return {
    for (final language in vndbLanguages) language.id: language.label,
  };
}

VndbLanguage? vndbLanguageById(String id) {
  for (final language in vndbLanguages) {
    if (language.id.toLowerCase() == id.toLowerCase()) {
      return language;
    }
  }

  return null;
}
