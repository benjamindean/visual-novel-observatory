// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_ulist_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnUlistEntry _$VnUlistEntryFromJson(Map<String, dynamic> json) =>
    _VnUlistEntry(
      id: json['id'] as String,
      vote: (json['vote'] as num?)?.toInt(),
      labels:
          (json['labels'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$VnUlistEntryToJson(_VnUlistEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vote': instance.vote,
      'labels': instance.labels,
    };
