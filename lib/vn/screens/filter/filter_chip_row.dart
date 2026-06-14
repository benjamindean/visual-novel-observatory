import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class FilterChipRow<T> extends StatelessWidget {
  final Map<T, String> items;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onSelected;

  const FilterChipRow({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.entries.map((entry) {
          final isSelected = selectedValues.contains(entry.key);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (selected) {
                final newValues = List<T>.from(selectedValues);

                if (selected) {
                  newValues.add(entry.key);
                } else {
                  newValues.remove(entry.key);
                }

                onSelected(newValues);
              },
              backgroundColor: context.appSurface,
              selectedColor: context.appAccentTeal,
              checkmarkColor: context.colorScheme.onPrimary,
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
