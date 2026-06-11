import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_tag.freezed.dart';
part 'vn_tag.g.dart';

@freezed
abstract class VnTag with _$VnTag {
  const factory VnTag({
    @Default('') String id,
    @Default('') String name,
    @Default(0) int spoiler,
    double? rating,
    String? category,
  }) = _VnTag;

  factory VnTag.fromJson(Map<String, dynamic> json) => _$VnTagFromJson(json);
}
