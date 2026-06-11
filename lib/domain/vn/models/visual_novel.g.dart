// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visual_novel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisualNovel _$VisualNovelFromJson(Map<String, dynamic> json) => _VisualNovel(
  id: json['id'] as String,
  title: json['title'] as String,
  altTitle: json['alttitle'] as String?,
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  imageDims: (json['imageDims'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  imageSexual: (json['imageSexual'] as num?)?.toDouble(),
  released: json['released'] as String?,
  length: (json['length'] as num?)?.toInt(),
  lengthMinutes: (json['length_minutes'] as num?)?.toInt(),
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => VnTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  developers:
      (json['developers'] as List<dynamic>?)
          ?.map((e) => VnDeveloper.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  screenshots:
      (json['screenshots'] as List<dynamic>?)
          ?.map((e) => VnScreenshot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  aliases:
      (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  extLinks:
      (json['extlinks'] as List<dynamic>?)
          ?.map((e) => VnExternalLink.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$VisualNovelToJson(_VisualNovel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'alttitle': instance.altTitle,
      'description': instance.description,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'imageDims': instance.imageDims,
      'imageSexual': instance.imageSexual,
      'released': instance.released,
      'length': instance.length,
      'length_minutes': instance.lengthMinutes,
      'tags': instance.tags,
      'developers': instance.developers,
      'screenshots': instance.screenshots,
      'platforms': instance.platforms,
      'languages': instance.languages,
      'aliases': instance.aliases,
      'extlinks': instance.extLinks,
    };
