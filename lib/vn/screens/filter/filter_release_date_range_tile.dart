import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';
import 'filter_release_date_button.dart';

class FilterReleaseDateRangeTile extends StatelessWidget {
  const FilterReleaseDateRangeTile({
    super.key,
    required this.releasedFrom,
    required this.releasedTo,
    required this.onFromChanged,
    required this.onToChanged,
  });

  final String? releasedFrom;
  final String? releasedTo;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;

  @override
  Widget build(BuildContext context) {
    final hasSelectedDate = releasedFrom != null || releasedTo != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: FilterReleaseDateButton(
                label: 'From',
                value: releasedFrom,
                onTap: () => _pickFromDate(context),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: FilterReleaseDateButton(
                label: 'To',
                value: releasedTo,
                onTap: () => _pickToDate(context),
              ),
            ),
          ],
        ),
        if (hasSelectedDate) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                onFromChanged(null);
                onToChanged(null);
              },
              icon: const Icon(Icons.close_rounded, size: 18.0),
              label: const Text('Clear dates'),
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickFromDate(BuildContext context) async {
    final minimumDate = DateTime(1900);
    final maximumDate = _parseDate(releasedTo) ?? _latestSelectableDate();
    final initialDate = _clampDate(
      _parseDate(releasedFrom) ?? _parseDate(releasedTo) ?? DateTime.now(),
      minimumDate,
      maximumDate,
    );
    final picked = await _showReleaseDatePicker(
      context: context,
      helpText: 'Select earliest release date',
      initialDate: initialDate,
      firstDate: minimumDate,
      lastDate: maximumDate,
    );

    if (!context.mounted || picked == null) {
      return;
    }

    onFromChanged(_formatDate(picked));
  }

  Future<void> _pickToDate(BuildContext context) async {
    final minimumDate = _parseDate(releasedFrom) ?? DateTime(1900);
    final maximumDate = _latestSelectableDate();
    final initialDate = _clampDate(
      _parseDate(releasedTo) ?? _parseDate(releasedFrom) ?? DateTime.now(),
      minimumDate,
      maximumDate,
    );
    final picked = await _showReleaseDatePicker(
      context: context,
      helpText: 'Select latest release date',
      initialDate: initialDate,
      firstDate: minimumDate,
      lastDate: maximumDate,
    );

    if (!context.mounted || picked == null) {
      return;
    }

    onToChanged(_formatDate(picked));
  }

  Future<DateTime?> _showReleaseDatePicker({
    required BuildContext context,
    required String helpText,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    final theme = Theme.of(context);

    return showDatePicker(
      context: context,
      helpText: helpText,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }

        return Theme(
          data: theme,
          child: child,
        );
      },
    );
  }

  DateTime _latestSelectableDate() {
    final today = DateTime.now();

    return DateTime(today.year + 20, 12, 31);
  }

  DateTime _clampDate(
    DateTime date,
    DateTime minimumDate,
    DateTime maximumDate,
  ) {
    if (date.isBefore(minimumDate)) {
      return minimumDate;
    }

    if (date.isAfter(maximumDate)) {
      return maximumDate;
    }

    return date;
  }

  DateTime? _parseDate(String? value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
