// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_voice_actor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnVoiceActorAssociation _$VnVoiceActorAssociationFromJson(
  Map<String, dynamic> json,
) => _VnVoiceActorAssociation(
  character: VnCharacter.fromJson(json['character'] as Map<String, dynamic>),
  note: json['note'] as String?,
  staff: json['staff'] == null
      ? null
      : VnStaff.fromJson(json['staff'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VnVoiceActorAssociationToJson(
  _VnVoiceActorAssociation instance,
) => <String, dynamic>{
  'character': instance.character,
  'note': instance.note,
  'staff': instance.staff,
};
