// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_external_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnExternalLink {

 String get id; String get name; String get label; String get url;
/// Create a copy of VnExternalLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnExternalLinkCopyWith<VnExternalLink> get copyWith => _$VnExternalLinkCopyWithImpl<VnExternalLink>(this as VnExternalLink, _$identity);

  /// Serializes this VnExternalLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnExternalLink&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,label,url);

@override
String toString() {
  return 'VnExternalLink(id: $id, name: $name, label: $label, url: $url)';
}


}

/// @nodoc
abstract mixin class $VnExternalLinkCopyWith<$Res>  {
  factory $VnExternalLinkCopyWith(VnExternalLink value, $Res Function(VnExternalLink) _then) = _$VnExternalLinkCopyWithImpl;
@useResult
$Res call({
 String id, String name, String label, String url
});




}
/// @nodoc
class _$VnExternalLinkCopyWithImpl<$Res>
    implements $VnExternalLinkCopyWith<$Res> {
  _$VnExternalLinkCopyWithImpl(this._self, this._then);

  final VnExternalLink _self;
  final $Res Function(VnExternalLink) _then;

/// Create a copy of VnExternalLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? label = null,Object? url = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VnExternalLink].
extension VnExternalLinkPatterns on VnExternalLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnExternalLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnExternalLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnExternalLink value)  $default,){
final _that = this;
switch (_that) {
case _VnExternalLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnExternalLink value)?  $default,){
final _that = this;
switch (_that) {
case _VnExternalLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String label,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnExternalLink() when $default != null:
return $default(_that.id,_that.name,_that.label,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String label,  String url)  $default,) {final _that = this;
switch (_that) {
case _VnExternalLink():
return $default(_that.id,_that.name,_that.label,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String label,  String url)?  $default,) {final _that = this;
switch (_that) {
case _VnExternalLink() when $default != null:
return $default(_that.id,_that.name,_that.label,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnExternalLink implements VnExternalLink {
  const _VnExternalLink({required this.id, required this.name, required this.label, required this.url});
  factory _VnExternalLink.fromJson(Map<String, dynamic> json) => _$VnExternalLinkFromJson(json);

@override final  String id;
@override final  String name;
@override final  String label;
@override final  String url;

/// Create a copy of VnExternalLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnExternalLinkCopyWith<_VnExternalLink> get copyWith => __$VnExternalLinkCopyWithImpl<_VnExternalLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnExternalLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnExternalLink&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,label,url);

@override
String toString() {
  return 'VnExternalLink(id: $id, name: $name, label: $label, url: $url)';
}


}

/// @nodoc
abstract mixin class _$VnExternalLinkCopyWith<$Res> implements $VnExternalLinkCopyWith<$Res> {
  factory _$VnExternalLinkCopyWith(_VnExternalLink value, $Res Function(_VnExternalLink) _then) = __$VnExternalLinkCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String label, String url
});




}
/// @nodoc
class __$VnExternalLinkCopyWithImpl<$Res>
    implements _$VnExternalLinkCopyWith<$Res> {
  __$VnExternalLinkCopyWithImpl(this._self, this._then);

  final _VnExternalLink _self;
  final $Res Function(_VnExternalLink) _then;

/// Create a copy of VnExternalLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? label = null,Object? url = null,}) {
  return _then(_VnExternalLink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
