// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnCharacter _$VnCharacterFromJson(Map<String, dynamic> json) => _VnCharacter(
  id: json['id'] as String,
  name: json['name'] as String,
  original: json['original'] as String?,
  description: json['description'] as String?,
  gender: (json['gender'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  bloodType: json['blood_type'] as String?,
  birthday: (json['birthday'] as List<dynamic>?)
      ?.map((e) => (e as num?)?.toInt())
      .toList(),
  height: (json['height'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toInt(),
  bust: (json['bust'] as num?)?.toInt(),
  waist: (json['waist'] as num?)?.toInt(),
  hips: (json['hips'] as num?)?.toInt(),
  cup: json['cup'] as String?,
  age: json['age'],
  imageUrl: json['imageUrl'] as String?,
  imageDims: (json['imageDims'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  imageSexual: (json['imageSexual'] as num?)?.toDouble(),
  imageViolence: (json['imageViolence'] as num?)?.toDouble(),
  vns:
      (json['vns'] as List<dynamic>?)
          ?.map((e) => VnCharacterVn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  traits:
      (json['traits'] as List<dynamic>?)
          ?.map((e) => VnCharacterTrait.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$VnCharacterToJson(_VnCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original': instance.original,
      'description': instance.description,
      'gender': instance.gender,
      'blood_type': instance.bloodType,
      'birthday': instance.birthday,
      'height': instance.height,
      'weight': instance.weight,
      'bust': instance.bust,
      'waist': instance.waist,
      'hips': instance.hips,
      'cup': instance.cup,
      'age': instance.age,
      'imageUrl': instance.imageUrl,
      'imageDims': instance.imageDims,
      'imageSexual': instance.imageSexual,
      'imageViolence': instance.imageViolence,
      'vns': instance.vns,
      'traits': instance.traits,
    };

_VnCharacterVn _$VnCharacterVnFromJson(Map<String, dynamic> json) =>
    _VnCharacterVn(
      id: json['id'] as String,
      title: json['title'] as String?,
      role: json['role'] as String?,
      spoiler: (json['spoiler'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VnCharacterVnToJson(_VnCharacterVn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'role': instance.role,
      'spoiler': instance.spoiler,
    };

_VnCharacterTrait _$VnCharacterTraitFromJson(Map<String, dynamic> json) =>
    _VnCharacterTrait(
      id: json['id'] as String,
      name: json['name'] as String,
      spoiler: (json['spoiler'] as num).toInt(),
    );

Map<String, dynamic> _$VnCharacterTraitToJson(_VnCharacterTrait instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'spoiler': instance.spoiler,
    };
