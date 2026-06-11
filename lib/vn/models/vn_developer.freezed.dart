// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_developer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnDeveloper {

 String get id; String get name; String? get original;
/// Create a copy of VnDeveloper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnDeveloperCopyWith<VnDeveloper> get copyWith => _$VnDeveloperCopyWithImpl<VnDeveloper>(this as VnDeveloper, _$identity);

  /// Serializes this VnDeveloper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnDeveloper&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,original);

@override
String toString() {
  return 'VnDeveloper(id: $id, name: $name, original: $original)';
}


}

/// @nodoc
abstract mixin class $VnDeveloperCopyWith<$Res>  {
  factory $VnDeveloperCopyWith(VnDeveloper value, $Res Function(VnDeveloper) _then) = _$VnDeveloperCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? original
});




}
/// @nodoc
class _$VnDeveloperCopyWithImpl<$Res>
    implements $VnDeveloperCopyWith<$Res> {
  _$VnDeveloperCopyWithImpl(this._self, this._then);

  final VnDeveloper _self;
  final $Res Function(VnDeveloper) _then;

/// Create a copy of VnDeveloper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? original = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VnDeveloper].
extension VnDeveloperPatterns on VnDeveloper {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnDeveloper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnDeveloper() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnDeveloper value)  $default,){
final _that = this;
switch (_that) {
case _VnDeveloper():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnDeveloper value)?  $default,){
final _that = this;
switch (_that) {
case _VnDeveloper() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? original)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnDeveloper() when $default != null:
return $default(_that.id,_that.name,_that.original);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? original)  $default,) {final _that = this;
switch (_that) {
case _VnDeveloper():
return $default(_that.id,_that.name,_that.original);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? original)?  $default,) {final _that = this;
switch (_that) {
case _VnDeveloper() when $default != null:
return $default(_that.id,_that.name,_that.original);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnDeveloper implements VnDeveloper {
  const _VnDeveloper({this.id = '', this.name = '', this.original});
  factory _VnDeveloper.fromJson(Map<String, dynamic> json) => _$VnDeveloperFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override final  String? original;

/// Create a copy of VnDeveloper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnDeveloperCopyWith<_VnDeveloper> get copyWith => __$VnDeveloperCopyWithImpl<_VnDeveloper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnDeveloperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnDeveloper&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,original);

@override
String toString() {
  return 'VnDeveloper(id: $id, name: $name, original: $original)';
}


}

/// @nodoc
abstract mixin class _$VnDeveloperCopyWith<$Res> implements $VnDeveloperCopyWith<$Res> {
  factory _$VnDeveloperCopyWith(_VnDeveloper value, $Res Function(_VnDeveloper) _then) = __$VnDeveloperCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? original
});




}
/// @nodoc
class __$VnDeveloperCopyWithImpl<$Res>
    implements _$VnDeveloperCopyWith<$Res> {
  __$VnDeveloperCopyWithImpl(this._self, this._then);

  final _VnDeveloper _self;
  final $Res Function(_VnDeveloper) _then;

/// Create a copy of VnDeveloper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? original = freezed,}) {
  return _then(_VnDeveloper(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
