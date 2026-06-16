// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_relation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnRelation {

 String get relation;@JsonKey(name: 'relation_official') bool get relationOfficial; VisualNovel get vn;
/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnRelationCopyWith<VnRelation> get copyWith => _$VnRelationCopyWithImpl<VnRelation>(this as VnRelation, _$identity);

  /// Serializes this VnRelation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnRelation&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.relationOfficial, relationOfficial) || other.relationOfficial == relationOfficial)&&(identical(other.vn, vn) || other.vn == vn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relation,relationOfficial,vn);

@override
String toString() {
  return 'VnRelation(relation: $relation, relationOfficial: $relationOfficial, vn: $vn)';
}


}

/// @nodoc
abstract mixin class $VnRelationCopyWith<$Res>  {
  factory $VnRelationCopyWith(VnRelation value, $Res Function(VnRelation) _then) = _$VnRelationCopyWithImpl;
@useResult
$Res call({
 String relation,@JsonKey(name: 'relation_official') bool relationOfficial, VisualNovel vn
});


$VisualNovelCopyWith<$Res> get vn;

}
/// @nodoc
class _$VnRelationCopyWithImpl<$Res>
    implements $VnRelationCopyWith<$Res> {
  _$VnRelationCopyWithImpl(this._self, this._then);

  final VnRelation _self;
  final $Res Function(VnRelation) _then;

/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relation = null,Object? relationOfficial = null,Object? vn = null,}) {
  return _then(_self.copyWith(
relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,relationOfficial: null == relationOfficial ? _self.relationOfficial : relationOfficial // ignore: cast_nullable_to_non_nullable
as bool,vn: null == vn ? _self.vn : vn // ignore: cast_nullable_to_non_nullable
as VisualNovel,
  ));
}
/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VisualNovelCopyWith<$Res> get vn {
  
  return $VisualNovelCopyWith<$Res>(_self.vn, (value) {
    return _then(_self.copyWith(vn: value));
  });
}
}


/// Adds pattern-matching-related methods to [VnRelation].
extension VnRelationPatterns on VnRelation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnRelation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnRelation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnRelation value)  $default,){
final _that = this;
switch (_that) {
case _VnRelation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnRelation value)?  $default,){
final _that = this;
switch (_that) {
case _VnRelation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String relation, @JsonKey(name: 'relation_official')  bool relationOfficial,  VisualNovel vn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnRelation() when $default != null:
return $default(_that.relation,_that.relationOfficial,_that.vn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String relation, @JsonKey(name: 'relation_official')  bool relationOfficial,  VisualNovel vn)  $default,) {final _that = this;
switch (_that) {
case _VnRelation():
return $default(_that.relation,_that.relationOfficial,_that.vn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String relation, @JsonKey(name: 'relation_official')  bool relationOfficial,  VisualNovel vn)?  $default,) {final _that = this;
switch (_that) {
case _VnRelation() when $default != null:
return $default(_that.relation,_that.relationOfficial,_that.vn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnRelation implements VnRelation {
  const _VnRelation({required this.relation, @JsonKey(name: 'relation_official') required this.relationOfficial, required this.vn});
  factory _VnRelation.fromJson(Map<String, dynamic> json) => _$VnRelationFromJson(json);

@override final  String relation;
@override@JsonKey(name: 'relation_official') final  bool relationOfficial;
@override final  VisualNovel vn;

/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnRelationCopyWith<_VnRelation> get copyWith => __$VnRelationCopyWithImpl<_VnRelation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnRelationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnRelation&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.relationOfficial, relationOfficial) || other.relationOfficial == relationOfficial)&&(identical(other.vn, vn) || other.vn == vn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relation,relationOfficial,vn);

@override
String toString() {
  return 'VnRelation(relation: $relation, relationOfficial: $relationOfficial, vn: $vn)';
}


}

/// @nodoc
abstract mixin class _$VnRelationCopyWith<$Res> implements $VnRelationCopyWith<$Res> {
  factory _$VnRelationCopyWith(_VnRelation value, $Res Function(_VnRelation) _then) = __$VnRelationCopyWithImpl;
@override @useResult
$Res call({
 String relation,@JsonKey(name: 'relation_official') bool relationOfficial, VisualNovel vn
});


@override $VisualNovelCopyWith<$Res> get vn;

}
/// @nodoc
class __$VnRelationCopyWithImpl<$Res>
    implements _$VnRelationCopyWith<$Res> {
  __$VnRelationCopyWithImpl(this._self, this._then);

  final _VnRelation _self;
  final $Res Function(_VnRelation) _then;

/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relation = null,Object? relationOfficial = null,Object? vn = null,}) {
  return _then(_VnRelation(
relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,relationOfficial: null == relationOfficial ? _self.relationOfficial : relationOfficial // ignore: cast_nullable_to_non_nullable
as bool,vn: null == vn ? _self.vn : vn // ignore: cast_nullable_to_non_nullable
as VisualNovel,
  ));
}

/// Create a copy of VnRelation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VisualNovelCopyWith<$Res> get vn {
  
  return $VisualNovelCopyWith<$Res>(_self.vn, (value) {
    return _then(_self.copyWith(vn: value));
  });
}
}

// dart format on
