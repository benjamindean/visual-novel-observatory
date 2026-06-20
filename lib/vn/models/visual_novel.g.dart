// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visual_novel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisualNovel _$VisualNovelFromJson(Map<String, dynamic> json) => _VisualNovel(
  id: json['id'] as String,
  title: json['title'] as String,
  altTitle: json['alttitle'] as String?,
  titles:
      (json['titles'] as List<dynamic>?)
          ?.map((e) => VnTitle.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  description: json['description'] as String?,
  average: (json['average'] as num?)?.toDouble(),
  rating: (json['rating'] as num?)?.toDouble(),
  votecount: (json['votecount'] as num?)?.toInt(),
  imageUrl: json['imageUrl'] as String?,
  imageDims: (json['imageDims'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  imageSexual: (json['imageSexual'] as num?)?.toDouble(),
  imageViolence: (json['imageViolence'] as num?)?.toDouble(),
  released: json['released'] as String?,
  originalLanguage: json['olang'] as String?,
  devStatus: (json['devstatus'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  lengthMinutes: (json['length_minutes'] as num?)?.toInt(),
  lengthVotes: (json['length_votes'] as num?)?.toInt(),
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
  voiceActors:
      (json['va'] as List<dynamic>?)
          ?.map(
            (e) => VnVoiceActorAssociation.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  relations:
      (json['relations'] as List<dynamic>?)
          ?.map((e) => VnRelation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$VisualNovelToJson(_VisualNovel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'alttitle': instance.altTitle,
      'titles': instance.titles,
      'description': instance.description,
      'average': instance.average,
      'rating': instance.rating,
      'votecount': instance.votecount,
      'imageUrl': instance.imageUrl,
      'imageDims': instance.imageDims,
      'imageSexual': instance.imageSexual,
      'imageViolence': instance.imageViolence,
      'released': instance.released,
      'olang': instance.originalLanguage,
      'devstatus': instance.devStatus,
      'length': instance.length,
      'length_minutes': instance.lengthMinutes,
      'length_votes': instance.lengthVotes,
      'tags': instance.tags,
      'developers': instance.developers,
      'screenshots': instance.screenshots,
      'platforms': instance.platforms,
      'languages': instance.languages,
      'aliases': instance.aliases,
      'extlinks': instance.extLinks,
      'va': instance.voiceActors,
      'relations': instance.relations,
    };

_VnTitle _$VnTitleFromJson(Map<String, dynamic> json) => _VnTitle(
  lang: json['lang'] as String,
  title: json['title'] as String,
  latin: json['latin'] as String?,
  official: json['official'] as bool? ?? false,
  main: json['main'] as bool? ?? false,
);

Map<String, dynamic> _$VnTitleToJson(_VnTitle instance) => <String, dynamic>{
  'lang': instance.lang,
  'title': instance.title,
  'latin': instance.latin,
  'official': instance.official,
  'main': instance.main,
};
