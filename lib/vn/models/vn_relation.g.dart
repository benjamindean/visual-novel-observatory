// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnRelation _$VnRelationFromJson(Map<String, dynamic> json) => _VnRelation(
  relation: json['relation'] as String,
  relationOfficial: json['relation_official'] as bool,
  vn: VisualNovel.fromJson(json['vn'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VnRelationToJson(_VnRelation instance) =>
    <String, dynamic>{
      'relation': instance.relation,
      'relation_official': instance.relationOfficial,
      'vn': instance.vn,
    };
