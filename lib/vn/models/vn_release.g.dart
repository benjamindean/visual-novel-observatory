// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnRelease _$VnReleaseFromJson(Map<String, dynamic> json) => _VnRelease(
  id: json['id'] as String,
  title: json['title'] as String,
  altTitle: json['alttitle'] as String?,
  released: json['released'] as String?,
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => VnReleaseLanguage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  vns:
      (json['vns'] as List<dynamic>?)
          ?.map((e) => VnReleaseVn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  minage: (json['minage'] as num?)?.toInt(),
  patch: json['patch'] as bool? ?? false,
  freeware: json['freeware'] as bool? ?? false,
  uncensored: json['uncensored'] as bool?,
  official: json['official'] as bool? ?? false,
);

Map<String, dynamic> _$VnReleaseToJson(_VnRelease instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'alttitle': instance.altTitle,
      'released': instance.released,
      'platforms': instance.platforms,
      'languages': instance.languages,
      'vns': instance.vns,
      'minage': instance.minage,
      'patch': instance.patch,
      'freeware': instance.freeware,
      'uncensored': instance.uncensored,
      'official': instance.official,
    };

_VnReleaseLanguage _$VnReleaseLanguageFromJson(Map<String, dynamic> json) =>
    _VnReleaseLanguage(
      lang: json['lang'] as String,
      title: json['title'] as String?,
      latin: json['latin'] as String?,
      mtl: json['mtl'] as bool? ?? false,
      main: json['main'] as bool? ?? false,
    );

Map<String, dynamic> _$VnReleaseLanguageToJson(_VnReleaseLanguage instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'title': instance.title,
      'latin': instance.latin,
      'mtl': instance.mtl,
      'main': instance.main,
    };

_VnReleaseVn _$VnReleaseVnFromJson(Map<String, dynamic> json) => _VnReleaseVn(
  id: json['id'] as String,
  title: json['title'] as String?,
  rtype: json['rtype'] as String?,
);

Map<String, dynamic> _$VnReleaseVnToJson(_VnReleaseVn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rtype': instance.rtype,
    };
