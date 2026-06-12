import 'package:freezed_annotation/freezed_annotation.dart';
import 'visual_novel.dart';

part 'vn_ulist_entry.freezed.dart';
part 'vn_ulist_entry.g.dart';

@freezed
abstract class VnUlistEntry with _$VnUlistEntry {
  const factory VnUlistEntry({
    required String id,
    int? vote,
    @Default([]) List<int> labels,
    VisualNovel? vn,
  }) = _VnUlistEntry;

  factory VnUlistEntry.fromJson(Map<String, dynamic> json) =>
      _$VnUlistEntryFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final adjustedJson = Map<String, dynamic>.from(json);
    final vnJson = json['vn'];

    if (vnJson != null && vnJson is Map) {
      final adjustedVn = Map<String, dynamic>.from(vnJson);

      if (adjustedVn['id'] == null) {
        adjustedVn['id'] = json['id'];
      }

      adjustedJson['vn'] = adjustedVn;
    }

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
