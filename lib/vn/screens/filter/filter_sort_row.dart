import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class FilterSortRow extends StatelessWidget {
  final Map<String, String> items;
  final String selectedField;
  final bool isDescending;
  final void Function(String field, bool descending) onChanged;

  const FilterSortRow({
    super.key,
    required this.items,
    required this.selectedField,
    required this.isDescending,
    required this.onChanged,
  });

  /// Fields that default to descending when first selected.
  static const _descendingDefaults = {'rating', 'votecount', 'released'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.entries.map((entry) {
          final isSelected = entry.key == selectedField;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(entry.value),
                  if (isSelected) ...[
                    const SizedBox(width: 4),
                    Icon(
                      isDescending
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      size: 14,
                      color: context.colorScheme.onPrimary,
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (_) {
                if (isSelected) {
                  // Toggle direction on re-tap
                  onChanged(entry.key, !isDescending);
                } else {
                  // Select with sensible default direction
                  final defaultDescending = _descendingDefaults.contains(
                    entry.key,
                  );

                  onChanged(entry.key, defaultDescending);
                }
              },
              backgroundColor: context.colorScheme.surfaceContainerHigh,
              selectedColor: context.appAccentTeal,
              checkmarkColor: Colors.transparent,
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected
                    ? context.colorScheme.onPrimary
                    : context.appTextPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
