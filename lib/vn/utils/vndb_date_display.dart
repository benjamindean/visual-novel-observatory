const _monthLabels = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String formatVndbDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'TBA';
  }

  final parts = value.split('-');
  final year = int.tryParse(parts.first);

  if (year == null) {
    return value;
  }

  if (parts.length == 1) {
    return year.toString();
  }

  final month = int.tryParse(parts[1]);

  if (month == null || month < 1 || month > 12) {
    return value;
  }

  if (parts.length == 2) {
    return '${_monthLabels[month - 1]} $year';
  }

  final day = int.tryParse(parts[2]);

  if (day == null || day < 1 || day > 31) {
    return value;
  }

  final date = DateTime(year, month, day);

  if (date.year != year || date.month != month || date.day != day) {
    return value;
  }

  return '$day ${_monthLabels[month - 1]} $year';
}
