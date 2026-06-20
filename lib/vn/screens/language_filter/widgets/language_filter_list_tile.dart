import 'package:flutter/material.dart';

import '../../../constants/vndb_languages.dart';
import '../../../widgets/filter_selectable_list_tile.dart';
import '../../../widgets/language_flag_icon.dart';

class LanguageFilterListTile extends StatelessWidget {
  const LanguageFilterListTile({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final VndbLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterSelectableListTile(
      leading: LanguageFlagIcon(
        flag: language.flag,
      ),
      title: language.label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}
