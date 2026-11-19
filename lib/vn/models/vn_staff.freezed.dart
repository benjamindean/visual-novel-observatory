// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnStaff {

 String get id; String get name; String? get original;
/// Create a copy of VnStaff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnStaffCopyWith<VnStaff> get copyWith => _$VnStaffCopyWithImpl<VnStaff>(this as VnStaff, _$identity);

  /// Serializes this VnStaff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VnStaff;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnStaff&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.original, _this.original) || other.original == _this.original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VnStaff;
  return Object.hash(runtimeType,_this.id,_this.name,_this.original);
}

@override
String toString() {
  final _this = this as VnStaff;
  return 'VnStaff(id: ${_this.id}, name: ${_this.name}, original: ${_this.original})';
}


}

/// @nodoc
abstract mixin class $VnStaffCopyWith<$Res>  {
  factory $VnStaffCopyWith(VnStaff value, $Res Function(VnStaff) _then) = _$VnStaffCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? original
});




}
/// @nodoc
class _$VnStaffCopyWithImpl<$Res>
    implements $VnStaffCopyWith<$Res> {
  _$VnStaffCopyWithImpl(this._self, this._then);

  final VnStaff _self;
  final $Res Function(VnStaff) _then;

/// Create a copy of VnStaff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? original = freezed,}) {
  return _then(VnStaff(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VnStaff].
extension VnStaffPatterns on VnStaff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnStaff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnStaff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnStaff value)  $default,){
final _that = this;
switch (_that) {
case _VnStaff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnStaff value)?  $default,){
final _that = this;
switch (_that) {
case _VnStaff() when $default != null:
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
case _VnStaff() when $default != null:
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
case _VnStaff():
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
case _VnStaff() when $default != null:
return $default(_that.id,_that.name,_that.original);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnStaff implements VnStaff {
  const _VnStaff({required this.id, required this.name, this.original});
  factory _VnStaff.fromJson(Map<String, dynamic> json) => _$VnStaffFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? original;

/// Create a copy of VnStaff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnStaffCopyWith<_VnStaff> get copyWith => __$VnStaffCopyWithImpl<_VnStaff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnStaffToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnStaff&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,original);
}

@override
String toString() {
    return 'VnStaff(id: $id, name: $name, original: $original)';
}


}

/// @nodoc
abstract mixin class _$VnStaffCopyWith<$Res> implements $VnStaffCopyWith<$Res> {
  factory _$VnStaffCopyWith(_VnStaff value, $Res Function(_VnStaff) _then) = __$VnStaffCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? original
});




}
/// @nodoc
class __$VnStaffCopyWithImpl<$Res>
    implements _$VnStaffCopyWith<$Res> {
  __$VnStaffCopyWithImpl(this._self, this._then);

  final _VnStaff _self;
  final $Res Function(_VnStaff) _then;

/// Create a copy of VnStaff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? original = freezed,}) {
  return _then(_VnStaff(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
