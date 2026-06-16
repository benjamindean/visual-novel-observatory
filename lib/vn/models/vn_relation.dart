import 'package:freezed_annotation/freezed_annotation.dart';
import 'visual_novel.dart';

part 'vn_relation.freezed.dart';
part 'vn_relation.g.dart';

@freezed
abstract class VnRelation with _$VnRelation {
  const factory VnRelation({
    required String relation,
    @JsonKey(name: 'relation_official') required bool relationOfficial,
    required VisualNovel vn,
  }) = _VnRelation;

  factory VnRelation.fromJson(Map<String, dynamic> json) =>
      _$VnRelationFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    if (json.containsKey('vn')) {
      return json;
    }

    final adjusted = Map<String, dynamic>.from(json);
    final relation = adjusted.remove('relation') as String? ?? 'Related';
    final relationOfficial =
        adjusted.remove('relation_official') as bool? ?? false;

    return {
      'relation': relation,
      'relation_official': relationOfficial,
      'vn': adjusted,
    };
  }
}
