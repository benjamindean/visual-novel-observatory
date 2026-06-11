// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnTag _$VnTagFromJson(Map<String, dynamic> json) => _VnTag(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  spoiler: (json['spoiler'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble(),
);

Map<String, dynamic> _$VnTagToJson(_VnTag instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'spoiler': instance.spoiler,
  'rating': instance.rating,
};
