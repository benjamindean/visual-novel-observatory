import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_ulist_entry.freezed.dart';
part 'vn_ulist_entry.g.dart';

@freezed
abstract class VnUlistEntry with _$VnUlistEntry {
  const factory VnUlistEntry({
    required String id,
    int? vote,
    @Default([]) List<int> labels,
  }) = _VnUlistEntry;

  factory VnUlistEntry.fromJson(Map<String, dynamic> json) =>
      _$VnUlistEntryFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final adjustedJson = Map<String, dynamic>.from(json);

    final rawLabels = json['labels'] as List? ?? [];

    final normalizedLabels = rawLabels.map((e) {
      if (e is Map) {
        return e['id'] as int;
      }

      return e as int;
    }).toList();

    adjustedJson['labels'] = normalizedLabels;

    return adjustedJson;
  }
}
