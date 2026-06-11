import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_developer.freezed.dart';
part 'vn_developer.g.dart';

@freezed
abstract class VnDeveloper with _$VnDeveloper {
  const factory VnDeveloper({
    @Default('') String id,
    @Default('') String name,
    String? original,
  }) = _VnDeveloper;

  factory VnDeveloper.fromJson(Map<String, dynamic> json) =>
      _$VnDeveloperFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return json;
  }
}
