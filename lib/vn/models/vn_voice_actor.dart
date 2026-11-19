import 'package:freezed_annotation/freezed_annotation.dart';

import 'vn_character.dart';
import 'vn_staff.dart';

part 'vn_voice_actor.freezed.dart';
part 'vn_voice_actor.g.dart';

@freezed
abstract class VnVoiceActorAssociation with _$VnVoiceActorAssociation {
  const factory VnVoiceActorAssociation({
    required VnCharacter character,
    String? note,
    VnStaff? staff,
  }) = _VnVoiceActorAssociation;

  factory VnVoiceActorAssociation.fromJson(Map<String, dynamic> json) =>
      _$VnVoiceActorAssociationFromJson(json);
}
