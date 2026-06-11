import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_external_link.freezed.dart';
part 'vn_external_link.g.dart';

@freezed
abstract class VnExternalLink with _$VnExternalLink {
  const factory VnExternalLink({
    required String id,
    required String name,
    required String label,
    required String url,
  }) = _VnExternalLink;

  factory VnExternalLink.fromJson(Map<String, dynamic> json) =>
      _$VnExternalLinkFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final idString = rawId?.toString() ?? '';
    final adjustedJson = Map<String, dynamic>.from(json);

    adjustedJson['id'] = idString;

    return adjustedJson;
  }
}
