// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_voice_actor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnVoiceActorAssociation {

 VnCharacter get character; String? get note; VnStaff? get staff;
/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnVoiceActorAssociationCopyWith<VnVoiceActorAssociation> get copyWith => _$VnVoiceActorAssociationCopyWithImpl<VnVoiceActorAssociation>(this as VnVoiceActorAssociation, _$identity);

  /// Serializes this VnVoiceActorAssociation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VnVoiceActorAssociation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnVoiceActorAssociation&&(identical(other.character, _this.character) || other.character == _this.character)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.staff, _this.staff) || other.staff == _this.staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VnVoiceActorAssociation;
  return Object.hash(runtimeType,_this.character,_this.note,_this.staff);
}

@override
String toString() {
  final _this = this as VnVoiceActorAssociation;
  return 'VnVoiceActorAssociation(character: ${_this.character}, note: ${_this.note}, staff: ${_this.staff})';
}


}

/// @nodoc
abstract mixin class $VnVoiceActorAssociationCopyWith<$Res>  {
  factory $VnVoiceActorAssociationCopyWith(VnVoiceActorAssociation value, $Res Function(VnVoiceActorAssociation) _then) = _$VnVoiceActorAssociationCopyWithImpl;
@useResult
$Res call({
 VnCharacter character, String? note, VnStaff? staff
});


$VnCharacterCopyWith<$Res> get character;$VnStaffCopyWith<$Res>? get staff;

}
/// @nodoc
class _$VnVoiceActorAssociationCopyWithImpl<$Res>
    implements $VnVoiceActorAssociationCopyWith<$Res> {
  _$VnVoiceActorAssociationCopyWithImpl(this._self, this._then);

  final VnVoiceActorAssociation _self;
  final $Res Function(VnVoiceActorAssociation) _then;

/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? character = null,Object? note = freezed,Object? staff = freezed,}) {
  return _then(VnVoiceActorAssociation(
character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as VnCharacter,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,staff: freezed == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as VnStaff?,
  ));
}
/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VnCharacterCopyWith<$Res> get character {
  
  return $VnCharacterCopyWith<$Res>(_self.character, (value) {
    return _then(_self.copyWith(character: value));
  });
}/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VnStaffCopyWith<$Res>? get staff {
    if (_self.staff == null) {
    return null;
  }

  return $VnStaffCopyWith<$Res>(_self.staff!, (value) {
    return _then(_self.copyWith(staff: value));
  });
}
}


/// Adds pattern-matching-related methods to [VnVoiceActorAssociation].
extension VnVoiceActorAssociationPatterns on VnVoiceActorAssociation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnVoiceActorAssociation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnVoiceActorAssociation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnVoiceActorAssociation value)  $default,){
final _that = this;
switch (_that) {
case _VnVoiceActorAssociation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnVoiceActorAssociation value)?  $default,){
final _that = this;
switch (_that) {
case _VnVoiceActorAssociation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VnCharacter character,  String? note,  VnStaff? staff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnVoiceActorAssociation() when $default != null:
return $default(_that.character,_that.note,_that.staff);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VnCharacter character,  String? note,  VnStaff? staff)  $default,) {final _that = this;
switch (_that) {
case _VnVoiceActorAssociation():
return $default(_that.character,_that.note,_that.staff);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VnCharacter character,  String? note,  VnStaff? staff)?  $default,) {final _that = this;
switch (_that) {
case _VnVoiceActorAssociation() when $default != null:
return $default(_that.character,_that.note,_that.staff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnVoiceActorAssociation implements VnVoiceActorAssociation {
  const _VnVoiceActorAssociation({required this.character, this.note, this.staff});
  factory _VnVoiceActorAssociation.fromJson(Map<String, dynamic> json) => _$VnVoiceActorAssociationFromJson(json);

@override final  VnCharacter character;
@override final  String? note;
@override final  VnStaff? staff;

/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnVoiceActorAssociationCopyWith<_VnVoiceActorAssociation> get copyWith => __$VnVoiceActorAssociationCopyWithImpl<_VnVoiceActorAssociation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnVoiceActorAssociationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnVoiceActorAssociation&&(identical(other.character, character) || other.character == character)&&(identical(other.note, note) || other.note == note)&&(identical(other.staff, staff) || other.staff == staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,character,note,staff);
}

@override
String toString() {
    return 'VnVoiceActorAssociation(character: $character, note: $note, staff: $staff)';
}


}

/// @nodoc
abstract mixin class _$VnVoiceActorAssociationCopyWith<$Res> implements $VnVoiceActorAssociationCopyWith<$Res> {
  factory _$VnVoiceActorAssociationCopyWith(_VnVoiceActorAssociation value, $Res Function(_VnVoiceActorAssociation) _then) = __$VnVoiceActorAssociationCopyWithImpl;
@override @useResult
$Res call({
 VnCharacter character, String? note, VnStaff? staff
});


@override $VnCharacterCopyWith<$Res> get character;@override $VnStaffCopyWith<$Res>? get staff;

}
/// @nodoc
class __$VnVoiceActorAssociationCopyWithImpl<$Res>
    implements _$VnVoiceActorAssociationCopyWith<$Res> {
  __$VnVoiceActorAssociationCopyWithImpl(this._self, this._then);

  final _VnVoiceActorAssociation _self;
  final $Res Function(_VnVoiceActorAssociation) _then;

/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? character = null,Object? note = freezed,Object? staff = freezed,}) {
  return _then(_VnVoiceActorAssociation(
character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as VnCharacter,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,staff: freezed == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as VnStaff?,
  ));
}

/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VnCharacterCopyWith<$Res> get character {
  
  return $VnCharacterCopyWith<$Res>(_self.character, (value) {
    return _then(_self.copyWith(character: value));
  });
}/// Create a copy of VnVoiceActorAssociation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VnStaffCopyWith<$Res>? get staff {
    if (_self.staff == null) {
    return null;
  }

  return $VnStaffCopyWith<$Res>(_self.staff!, (value) {
    return _then(_self.copyWith(staff: value));
  });
}
}

// dart format on
