// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_ulist_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnUlistEntry _$VnUlistEntryFromJson(Map<String, dynamic> json) =>
    _VnUlistEntry(
      id: json['id'] as String,
      added: (json['added'] as num?)?.toInt(),
      vote: (json['vote'] as num?)?.toInt(),
      labels:
          (json['labels'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      vn: json['vn'] == null
          ? null
          : VisualNovel.fromJson(json['vn'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VnUlistEntryToJson(_VnUlistEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'added': instance.added,
      'vote': instance.vote,
      'labels': instance.labels,
      'vn': instance.vn,
    };
