// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vndb_label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VndbLabel {

 int get id; String get label;
/// Create a copy of VndbLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VndbLabelCopyWith<VndbLabel> get copyWith => _$VndbLabelCopyWithImpl<VndbLabel>(this as VndbLabel, _$identity);

  /// Serializes this VndbLabel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VndbLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'VndbLabel(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $VndbLabelCopyWith<$Res>  {
  factory $VndbLabelCopyWith(VndbLabel value, $Res Function(VndbLabel) _then) = _$VndbLabelCopyWithImpl;
@useResult
$Res call({
 int id, String label
});




}
/// @nodoc
class _$VndbLabelCopyWithImpl<$Res>
    implements $VndbLabelCopyWith<$Res> {
  _$VndbLabelCopyWithImpl(this._self, this._then);

  final VndbLabel _self;
  final $Res Function(VndbLabel) _then;

/// Create a copy of VndbLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VndbLabel].
extension VndbLabelPatterns on VndbLabel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VndbLabel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VndbLabel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VndbLabel value)  $default,){
final _that = this;
switch (_that) {
case _VndbLabel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VndbLabel value)?  $default,){
final _that = this;
switch (_that) {
case _VndbLabel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VndbLabel() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String label)  $default,) {final _that = this;
switch (_that) {
case _VndbLabel():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _VndbLabel() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VndbLabel implements VndbLabel {
  const _VndbLabel({required this.id, required this.label});
  factory _VndbLabel.fromJson(Map<String, dynamic> json) => _$VndbLabelFromJson(json);

@override final  int id;
@override final  String label;

/// Create a copy of VndbLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VndbLabelCopyWith<_VndbLabel> get copyWith => __$VndbLabelCopyWithImpl<_VndbLabel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VndbLabelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VndbLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'VndbLabel(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$VndbLabelCopyWith<$Res> implements $VndbLabelCopyWith<$Res> {
  factory _$VndbLabelCopyWith(_VndbLabel value, $Res Function(_VndbLabel) _then) = __$VndbLabelCopyWithImpl;
@override @useResult
$Res call({
 int id, String label
});




}
/// @nodoc
class __$VndbLabelCopyWithImpl<$Res>
    implements _$VndbLabelCopyWith<$Res> {
  __$VndbLabelCopyWithImpl(this._self, this._then);

  final _VndbLabel _self;
  final $Res Function(_VndbLabel) _then;

/// Create a copy of VndbLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_VndbLabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
