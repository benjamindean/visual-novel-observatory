const String vndbNoSexualContentTagId = 'g235';
const String vndbViolenceTagId = 'g157';
const int vndbContentSafetyTagSpoilerLevel = 2;
const int vndbContentSafetyMinTagLevel = 0;

const List<String> _blockedViolentTagIds = [
  vndbViolenceTagId,
  'g158',
  'g161',
  'g159',
  'g2542',
];

const List<String> _blockedSexualTagIds = [
  'g23',
  'g3373',
  'g304',
  'g214',
  'g1094',
];

List<dynamic> vndbSafeContentFilters() {
  return [
    _includedTagFilter(vndbNoSexualContentTagId),
    for (final tagId in _blockedViolentTagIds) _excludedTagFilter(tagId),
    for (final tagId in _blockedSexualTagIds) _excludedTagFilter(tagId),
  ];
}

List<dynamic> applyVndbSafeContentFilters({
  required List<dynamic> filters,
  required bool disableExplicitContent,
}) {
  final normalizedFilters = _normalizedFilters(filters);

  if (!disableExplicitContent) {
    return _combineWithAnd(normalizedFilters);
  }

  return _combineWithAnd([
    ...normalizedFilters,
    ...vndbSafeContentFilters(),
  ]);
}

List<dynamic> _includedTagFilter(String tagId) {
  return [
    'tag',
    '=',
    _tagFilterValue(tagId),
  ];
}

List<dynamic> _excludedTagFilter(String tagId) {
  return [
    'tag',
    '!=',
    _tagFilterValue(tagId),
  ];
}

List<dynamic> _tagFilterValue(String tagId) {
  return [
    tagId,
    vndbContentSafetyTagSpoilerLevel,
    vndbContentSafetyMinTagLevel,
  ];
}

List<dynamic> _normalizedFilters(List<dynamic> filters) {
  if (filters.isEmpty) {
    return const [];
  }

  return [filters];
}

List<dynamic> _combineWithAnd(List<dynamic> filters) {
  if (filters.isEmpty) {
    return const [];
  }

  if (filters.length == 1) {
    return List<dynamic>.from(filters.first as List);
  }

  return [
    'and',
    ...filters,
  ];
}
