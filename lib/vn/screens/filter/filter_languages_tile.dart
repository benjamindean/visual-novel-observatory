import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../constants/vndb_languages.dart';
import '../../widgets/app_chip.dart';
import '../language_filter/language_filter_screen.dart';

class FilterLanguagesTile extends StatelessWidget {
  const FilterLanguagesTile({
    super.key,
    required this.selectedLanguages,
    required this.onLanguagesChanged,
  });

  final List<String> selectedLanguages;
  final ValueChanged<List<String>> onLanguagesChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push<List<String>>(
                MaterialPageRoute(
                  builder: (context) => LanguageFilterScreen(
                    initialLanguageIds: selectedLanguages,
                  ),
                ),
              )
              .then((result) {
                if (result != null) {
                  onLanguagesChanged(result);
                }
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: selectedLanguages.isEmpty
                    ? Text(
                        'Select Languages...',
                        style: TextStyle(
                          color: context.appTextSecondary,
                          fontSize: 14,
                        ),
                      )
                    : Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedLanguages.map((languageId) {
                          final language = vndbLanguageById(languageId);

                          return AppChip(
                            label: language?.label ?? languageId.toUpperCase(),
                            backgroundColor:
                                context.colorScheme.primaryContainer,
                            foregroundColor:
                                context.colorScheme.onPrimaryContainer,
                          );
                        }).toList(),
                      ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: context.appTextMuted),
            ],
          ),
        ),
      ),
    );
  }
}
