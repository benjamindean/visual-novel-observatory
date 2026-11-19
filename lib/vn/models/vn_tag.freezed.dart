// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnTag {

 String get id; String get name; int get spoiler; double? get rating; String? get category;
/// Create a copy of VnTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnTagCopyWith<VnTag> get copyWith => _$VnTagCopyWithImpl<VnTag>(this as VnTag, _$identity);

  /// Serializes this VnTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VnTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnTag&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.spoiler, _this.spoiler) || other.spoiler == _this.spoiler)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.category, _this.category) || other.category == _this.category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VnTag;
  return Object.hash(runtimeType,_this.id,_this.name,_this.spoiler,_this.rating,_this.category);
}

@override
String toString() {
  final _this = this as VnTag;
  return 'VnTag(id: ${_this.id}, name: ${_this.name}, spoiler: ${_this.spoiler}, rating: ${_this.rating}, category: ${_this.category})';
}


}

/// @nodoc
abstract mixin class $VnTagCopyWith<$Res>  {
  factory $VnTagCopyWith(VnTag value, $Res Function(VnTag) _then) = _$VnTagCopyWithImpl;
@useResult
$Res call({
 String id, String name, int spoiler, double? rating, String? category
});




}
/// @nodoc
class _$VnTagCopyWithImpl<$Res>
    implements $VnTagCopyWith<$Res> {
  _$VnTagCopyWithImpl(this._self, this._then);

  final VnTag _self;
  final $Res Function(VnTag) _then;

/// Create a copy of VnTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? spoiler = null,Object? rating = freezed,Object? category = freezed,}) {
  return _then(VnTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spoiler: null == spoiler ? _self.spoiler : spoiler // ignore: cast_nullable_to_non_nullable
as int,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VnTag].
extension VnTagPatterns on VnTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnTag value)  $default,){
final _that = this;
switch (_that) {
case _VnTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnTag value)?  $default,){
final _that = this;
switch (_that) {
case _VnTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int spoiler,  double? rating,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnTag() when $default != null:
return $default(_that.id,_that.name,_that.spoiler,_that.rating,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int spoiler,  double? rating,  String? category)  $default,) {final _that = this;
switch (_that) {
case _VnTag():
return $default(_that.id,_that.name,_that.spoiler,_that.rating,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int spoiler,  double? rating,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _VnTag() when $default != null:
return $default(_that.id,_that.name,_that.spoiler,_that.rating,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnTag implements VnTag {
  const _VnTag({this.id = '', this.name = '', this.spoiler = 0, this.rating, this.category});
  factory _VnTag.fromJson(Map<String, dynamic> json) => _$VnTagFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  int spoiler;
@override final  double? rating;
@override final  String? category;

/// Create a copy of VnTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnTagCopyWith<_VnTag> get copyWith => __$VnTagCopyWithImpl<_VnTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnTagToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnTag&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.spoiler, spoiler) || other.spoiler == spoiler)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,spoiler,rating,category);
}

@override
String toString() {
    return 'VnTag(id: $id, name: $name, spoiler: $spoiler, rating: $rating, category: $category)';
}


}

/// @nodoc
abstract mixin class _$VnTagCopyWith<$Res> implements $VnTagCopyWith<$Res> {
  factory _$VnTagCopyWith(_VnTag value, $Res Function(_VnTag) _then) = __$VnTagCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int spoiler, double? rating, String? category
});




}
/// @nodoc
class __$VnTagCopyWithImpl<$Res>
    implements _$VnTagCopyWith<$Res> {
  __$VnTagCopyWithImpl(this._self, this._then);

  final _VnTag _self;
  final $Res Function(_VnTag) _then;

/// Create a copy of VnTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? spoiler = null,Object? rating = freezed,Object? category = freezed,}) {
  return _then(_VnTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spoiler: null == spoiler ? _self.spoiler : spoiler // ignore: cast_nullable_to_non_nullable
as int,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
