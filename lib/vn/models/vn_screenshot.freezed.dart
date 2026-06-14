// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_screenshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnScreenshot {

 String get url; List<int> get dims; String? get thumbnail; double? get sexual; double? get violence;
/// Create a copy of VnScreenshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnScreenshotCopyWith<VnScreenshot> get copyWith => _$VnScreenshotCopyWithImpl<VnScreenshot>(this as VnScreenshot, _$identity);

  /// Serializes this VnScreenshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnScreenshot&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.dims, dims)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.sexual, sexual) || other.sexual == sexual)&&(identical(other.violence, violence) || other.violence == violence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(dims),thumbnail,sexual,violence);

@override
String toString() {
  return 'VnScreenshot(url: $url, dims: $dims, thumbnail: $thumbnail, sexual: $sexual, violence: $violence)';
}


}

/// @nodoc
abstract mixin class $VnScreenshotCopyWith<$Res>  {
  factory $VnScreenshotCopyWith(VnScreenshot value, $Res Function(VnScreenshot) _then) = _$VnScreenshotCopyWithImpl;
@useResult
$Res call({
 String url, List<int> dims, String? thumbnail, double? sexual, double? violence
});




}
/// @nodoc
class _$VnScreenshotCopyWithImpl<$Res>
    implements $VnScreenshotCopyWith<$Res> {
  _$VnScreenshotCopyWithImpl(this._self, this._then);

  final VnScreenshot _self;
  final $Res Function(VnScreenshot) _then;

/// Create a copy of VnScreenshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? dims = null,Object? thumbnail = freezed,Object? sexual = freezed,Object? violence = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,dims: null == dims ? _self.dims : dims // ignore: cast_nullable_to_non_nullable
as List<int>,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,sexual: freezed == sexual ? _self.sexual : sexual // ignore: cast_nullable_to_non_nullable
as double?,violence: freezed == violence ? _self.violence : violence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [VnScreenshot].
extension VnScreenshotPatterns on VnScreenshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnScreenshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnScreenshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnScreenshot value)  $default,){
final _that = this;
switch (_that) {
case _VnScreenshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnScreenshot value)?  $default,){
final _that = this;
switch (_that) {
case _VnScreenshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  List<int> dims,  String? thumbnail,  double? sexual,  double? violence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnScreenshot() when $default != null:
return $default(_that.url,_that.dims,_that.thumbnail,_that.sexual,_that.violence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  List<int> dims,  String? thumbnail,  double? sexual,  double? violence)  $default,) {final _that = this;
switch (_that) {
case _VnScreenshot():
return $default(_that.url,_that.dims,_that.thumbnail,_that.sexual,_that.violence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  List<int> dims,  String? thumbnail,  double? sexual,  double? violence)?  $default,) {final _that = this;
switch (_that) {
case _VnScreenshot() when $default != null:
return $default(_that.url,_that.dims,_that.thumbnail,_that.sexual,_that.violence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnScreenshot implements VnScreenshot {
  const _VnScreenshot({this.url = '', final  List<int> dims = const [0, 0], this.thumbnail, this.sexual, this.violence}): _dims = dims;
  factory _VnScreenshot.fromJson(Map<String, dynamic> json) => _$VnScreenshotFromJson(json);

@override@JsonKey() final  String url;
 final  List<int> _dims;
@override@JsonKey() List<int> get dims {
  if (_dims is EqualUnmodifiableListView) return _dims;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dims);
}

@override final  String? thumbnail;
@override final  double? sexual;
@override final  double? violence;

/// Create a copy of VnScreenshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnScreenshotCopyWith<_VnScreenshot> get copyWith => __$VnScreenshotCopyWithImpl<_VnScreenshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnScreenshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnScreenshot&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._dims, _dims)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.sexual, sexual) || other.sexual == sexual)&&(identical(other.violence, violence) || other.violence == violence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(_dims),thumbnail,sexual,violence);

@override
String toString() {
  return 'VnScreenshot(url: $url, dims: $dims, thumbnail: $thumbnail, sexual: $sexual, violence: $violence)';
}


}

/// @nodoc
abstract mixin class _$VnScreenshotCopyWith<$Res> implements $VnScreenshotCopyWith<$Res> {
  factory _$VnScreenshotCopyWith(_VnScreenshot value, $Res Function(_VnScreenshot) _then) = __$VnScreenshotCopyWithImpl;
@override @useResult
$Res call({
 String url, List<int> dims, String? thumbnail, double? sexual, double? violence
});




}
/// @nodoc
class __$VnScreenshotCopyWithImpl<$Res>
    implements _$VnScreenshotCopyWith<$Res> {
  __$VnScreenshotCopyWithImpl(this._self, this._then);

  final _VnScreenshot _self;
  final $Res Function(_VnScreenshot) _then;

/// Create a copy of VnScreenshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? dims = null,Object? thumbnail = freezed,Object? sexual = freezed,Object? violence = freezed,}) {
  return _then(_VnScreenshot(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,dims: null == dims ? _self._dims : dims // ignore: cast_nullable_to_non_nullable
as List<int>,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,sexual: freezed == sexual ? _self.sexual : sexual // ignore: cast_nullable_to_non_nullable
as double?,violence: freezed == violence ? _self.violence : violence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
