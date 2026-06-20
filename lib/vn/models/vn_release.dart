// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_release.freezed.dart';
part 'vn_release.g.dart';

@freezed
abstract class VnRelease with _$VnRelease {
  const VnRelease._();

  const factory VnRelease({
    required String id,
    required String title,
    @JsonKey(name: 'alttitle') String? altTitle,
    String? released,
    @Default([]) List<String> platforms,
    @Default([]) List<VnReleaseLanguage> languages,
    @Default([]) List<VnReleaseVn> vns,
    int? minage,
    @Default(false) bool patch,
    @Default(false) bool freeware,
    @Default(false) bool official,
  }) = _VnRelease;

  factory VnRelease.fromJson(Map<String, dynamic> json) =>
      _$VnReleaseFromJson(json);

  String? releaseTypeFor(String vnId) {
    for (final vn in vns) {
      if (vn.id == vnId) {
        return vn.rtype;
      }
    }

    return null;
  }
}

@freezed
abstract class VnReleaseLanguage with _$VnReleaseLanguage {
  const factory VnReleaseLanguage({
    required String lang,
    String? title,
    String? latin,
    @Default(false) bool mtl,
    @Default(false) bool main,
  }) = _VnReleaseLanguage;

  factory VnReleaseLanguage.fromJson(Map<String, dynamic> json) =>
      _$VnReleaseLanguageFromJson(json);
}

@freezed
abstract class VnReleaseVn with _$VnReleaseVn {
  const factory VnReleaseVn({
    required String id,
    String? title,
    String? rtype,
  }) = _VnReleaseVn;

  factory VnReleaseVn.fromJson(Map<String, dynamic> json) =>
      _$VnReleaseVnFromJson(json);
}
