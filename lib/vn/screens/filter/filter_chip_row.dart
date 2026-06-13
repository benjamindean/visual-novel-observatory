import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class FilterChipRow<T> extends StatelessWidget {
  final Map<T, String> items;
  final T? selectedValue;
  final ValueChanged<T?> onSelected;

  const FilterChipRow({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.entries.map((entry) {
          final isSelected = entry.key == selectedValue;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(selected ? entry.key : null);
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
