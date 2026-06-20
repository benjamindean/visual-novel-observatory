// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_release.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnRelease {

 String get id; String get title;@JsonKey(name: 'alttitle') String? get altTitle; String? get released; List<String> get platforms; List<VnReleaseLanguage> get languages; List<VnReleaseVn> get vns; int? get minage; bool get patch; bool get freeware; bool get official;
/// Create a copy of VnRelease
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnReleaseCopyWith<VnRelease> get copyWith => _$VnReleaseCopyWithImpl<VnRelease>(this as VnRelease, _$identity);

  /// Serializes this VnRelease to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnRelease&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.altTitle, altTitle) || other.altTitle == altTitle)&&(identical(other.released, released) || other.released == released)&&const DeepCollectionEquality().equals(other.platforms, platforms)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.vns, vns)&&(identical(other.minage, minage) || other.minage == minage)&&(identical(other.patch, patch) || other.patch == patch)&&(identical(other.freeware, freeware) || other.freeware == freeware)&&(identical(other.official, official) || other.official == official));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,altTitle,released,const DeepCollectionEquality().hash(platforms),const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(vns),minage,patch,freeware,official);

@override
String toString() {
  return 'VnRelease(id: $id, title: $title, altTitle: $altTitle, released: $released, platforms: $platforms, languages: $languages, vns: $vns, minage: $minage, patch: $patch, freeware: $freeware, official: $official)';
}


}

/// @nodoc
abstract mixin class $VnReleaseCopyWith<$Res>  {
  factory $VnReleaseCopyWith(VnRelease value, $Res Function(VnRelease) _then) = _$VnReleaseCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'alttitle') String? altTitle, String? released, List<String> platforms, List<VnReleaseLanguage> languages, List<VnReleaseVn> vns, int? minage, bool patch, bool freeware, bool official
});




}
/// @nodoc
class _$VnReleaseCopyWithImpl<$Res>
    implements $VnReleaseCopyWith<$Res> {
  _$VnReleaseCopyWithImpl(this._self, this._then);

  final VnRelease _self;
  final $Res Function(VnRelease) _then;

/// Create a copy of VnRelease
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? altTitle = freezed,Object? released = freezed,Object? platforms = null,Object? languages = null,Object? vns = null,Object? minage = freezed,Object? patch = null,Object? freeware = null,Object? official = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,altTitle: freezed == altTitle ? _self.altTitle : altTitle // ignore: cast_nullable_to_non_nullable
as String?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<VnReleaseLanguage>,vns: null == vns ? _self.vns : vns // ignore: cast_nullable_to_non_nullable
as List<VnReleaseVn>,minage: freezed == minage ? _self.minage : minage // ignore: cast_nullable_to_non_nullable
as int?,patch: null == patch ? _self.patch : patch // ignore: cast_nullable_to_non_nullable
as bool,freeware: null == freeware ? _self.freeware : freeware // ignore: cast_nullable_to_non_nullable
as bool,official: null == official ? _self.official : official // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VnRelease].
extension VnReleasePatterns on VnRelease {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnRelease value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnRelease() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnRelease value)  $default,){
final _that = this;
switch (_that) {
case _VnRelease():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnRelease value)?  $default,){
final _that = this;
switch (_that) {
case _VnRelease() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  String? released,  List<String> platforms,  List<VnReleaseLanguage> languages,  List<VnReleaseVn> vns,  int? minage,  bool patch,  bool freeware,  bool official)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnRelease() when $default != null:
return $default(_that.id,_that.title,_that.altTitle,_that.released,_that.platforms,_that.languages,_that.vns,_that.minage,_that.patch,_that.freeware,_that.official);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  String? released,  List<String> platforms,  List<VnReleaseLanguage> languages,  List<VnReleaseVn> vns,  int? minage,  bool patch,  bool freeware,  bool official)  $default,) {final _that = this;
switch (_that) {
case _VnRelease():
return $default(_that.id,_that.title,_that.altTitle,_that.released,_that.platforms,_that.languages,_that.vns,_that.minage,_that.patch,_that.freeware,_that.official);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  String? released,  List<String> platforms,  List<VnReleaseLanguage> languages,  List<VnReleaseVn> vns,  int? minage,  bool patch,  bool freeware,  bool official)?  $default,) {final _that = this;
switch (_that) {
case _VnRelease() when $default != null:
return $default(_that.id,_that.title,_that.altTitle,_that.released,_that.platforms,_that.languages,_that.vns,_that.minage,_that.patch,_that.freeware,_that.official);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnRelease extends VnRelease {
  const _VnRelease({required this.id, required this.title, @JsonKey(name: 'alttitle') this.altTitle, this.released, final  List<String> platforms = const [], final  List<VnReleaseLanguage> languages = const [], final  List<VnReleaseVn> vns = const [], this.minage, this.patch = false, this.freeware = false, this.official = false}): _platforms = platforms,_languages = languages,_vns = vns,super._();
  factory _VnRelease.fromJson(Map<String, dynamic> json) => _$VnReleaseFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'alttitle') final  String? altTitle;
@override final  String? released;
 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

 final  List<VnReleaseLanguage> _languages;
@override@JsonKey() List<VnReleaseLanguage> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<VnReleaseVn> _vns;
@override@JsonKey() List<VnReleaseVn> get vns {
  if (_vns is EqualUnmodifiableListView) return _vns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vns);
}

@override final  int? minage;
@override@JsonKey() final  bool patch;
@override@JsonKey() final  bool freeware;
@override@JsonKey() final  bool official;

/// Create a copy of VnRelease
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnReleaseCopyWith<_VnRelease> get copyWith => __$VnReleaseCopyWithImpl<_VnRelease>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnReleaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnRelease&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.altTitle, altTitle) || other.altTitle == altTitle)&&(identical(other.released, released) || other.released == released)&&const DeepCollectionEquality().equals(other._platforms, _platforms)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._vns, _vns)&&(identical(other.minage, minage) || other.minage == minage)&&(identical(other.patch, patch) || other.patch == patch)&&(identical(other.freeware, freeware) || other.freeware == freeware)&&(identical(other.official, official) || other.official == official));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,altTitle,released,const DeepCollectionEquality().hash(_platforms),const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_vns),minage,patch,freeware,official);

@override
String toString() {
  return 'VnRelease(id: $id, title: $title, altTitle: $altTitle, released: $released, platforms: $platforms, languages: $languages, vns: $vns, minage: $minage, patch: $patch, freeware: $freeware, official: $official)';
}


}

/// @nodoc
abstract mixin class _$VnReleaseCopyWith<$Res> implements $VnReleaseCopyWith<$Res> {
  factory _$VnReleaseCopyWith(_VnRelease value, $Res Function(_VnRelease) _then) = __$VnReleaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'alttitle') String? altTitle, String? released, List<String> platforms, List<VnReleaseLanguage> languages, List<VnReleaseVn> vns, int? minage, bool patch, bool freeware, bool official
});




}
/// @nodoc
class __$VnReleaseCopyWithImpl<$Res>
    implements _$VnReleaseCopyWith<$Res> {
  __$VnReleaseCopyWithImpl(this._self, this._then);

  final _VnRelease _self;
  final $Res Function(_VnRelease) _then;

/// Create a copy of VnRelease
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? altTitle = freezed,Object? released = freezed,Object? platforms = null,Object? languages = null,Object? vns = null,Object? minage = freezed,Object? patch = null,Object? freeware = null,Object? official = null,}) {
  return _then(_VnRelease(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,altTitle: freezed == altTitle ? _self.altTitle : altTitle // ignore: cast_nullable_to_non_nullable
as String?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<VnReleaseLanguage>,vns: null == vns ? _self._vns : vns // ignore: cast_nullable_to_non_nullable
as List<VnReleaseVn>,minage: freezed == minage ? _self.minage : minage // ignore: cast_nullable_to_non_nullable
as int?,patch: null == patch ? _self.patch : patch // ignore: cast_nullable_to_non_nullable
as bool,freeware: null == freeware ? _self.freeware : freeware // ignore: cast_nullable_to_non_nullable
as bool,official: null == official ? _self.official : official // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VnReleaseLanguage {

 String get lang; String? get title; String? get latin; bool get mtl; bool get main;
/// Create a copy of VnReleaseLanguage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnReleaseLanguageCopyWith<VnReleaseLanguage> get copyWith => _$VnReleaseLanguageCopyWithImpl<VnReleaseLanguage>(this as VnReleaseLanguage, _$identity);

  /// Serializes this VnReleaseLanguage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnReleaseLanguage&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.latin, latin) || other.latin == latin)&&(identical(other.mtl, mtl) || other.mtl == mtl)&&(identical(other.main, main) || other.main == main));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,title,latin,mtl,main);

@override
String toString() {
  return 'VnReleaseLanguage(lang: $lang, title: $title, latin: $latin, mtl: $mtl, main: $main)';
}


}

/// @nodoc
abstract mixin class $VnReleaseLanguageCopyWith<$Res>  {
  factory $VnReleaseLanguageCopyWith(VnReleaseLanguage value, $Res Function(VnReleaseLanguage) _then) = _$VnReleaseLanguageCopyWithImpl;
@useResult
$Res call({
 String lang, String? title, String? latin, bool mtl, bool main
});




}
/// @nodoc
class _$VnReleaseLanguageCopyWithImpl<$Res>
    implements $VnReleaseLanguageCopyWith<$Res> {
  _$VnReleaseLanguageCopyWithImpl(this._self, this._then);

  final VnReleaseLanguage _self;
  final $Res Function(VnReleaseLanguage) _then;

/// Create a copy of VnReleaseLanguage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lang = null,Object? title = freezed,Object? latin = freezed,Object? mtl = null,Object? main = null,}) {
  return _then(_self.copyWith(
lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,latin: freezed == latin ? _self.latin : latin // ignore: cast_nullable_to_non_nullable
as String?,mtl: null == mtl ? _self.mtl : mtl // ignore: cast_nullable_to_non_nullable
as bool,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VnReleaseLanguage].
extension VnReleaseLanguagePatterns on VnReleaseLanguage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnReleaseLanguage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnReleaseLanguage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnReleaseLanguage value)  $default,){
final _that = this;
switch (_that) {
case _VnReleaseLanguage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnReleaseLanguage value)?  $default,){
final _that = this;
switch (_that) {
case _VnReleaseLanguage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lang,  String? title,  String? latin,  bool mtl,  bool main)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnReleaseLanguage() when $default != null:
return $default(_that.lang,_that.title,_that.latin,_that.mtl,_that.main);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lang,  String? title,  String? latin,  bool mtl,  bool main)  $default,) {final _that = this;
switch (_that) {
case _VnReleaseLanguage():
return $default(_that.lang,_that.title,_that.latin,_that.mtl,_that.main);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lang,  String? title,  String? latin,  bool mtl,  bool main)?  $default,) {final _that = this;
switch (_that) {
case _VnReleaseLanguage() when $default != null:
return $default(_that.lang,_that.title,_that.latin,_that.mtl,_that.main);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnReleaseLanguage implements VnReleaseLanguage {
  const _VnReleaseLanguage({required this.lang, this.title, this.latin, this.mtl = false, this.main = false});
  factory _VnReleaseLanguage.fromJson(Map<String, dynamic> json) => _$VnReleaseLanguageFromJson(json);

@override final  String lang;
@override final  String? title;
@override final  String? latin;
@override@JsonKey() final  bool mtl;
@override@JsonKey() final  bool main;

/// Create a copy of VnReleaseLanguage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnReleaseLanguageCopyWith<_VnReleaseLanguage> get copyWith => __$VnReleaseLanguageCopyWithImpl<_VnReleaseLanguage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnReleaseLanguageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnReleaseLanguage&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.latin, latin) || other.latin == latin)&&(identical(other.mtl, mtl) || other.mtl == mtl)&&(identical(other.main, main) || other.main == main));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,title,latin,mtl,main);

@override
String toString() {
  return 'VnReleaseLanguage(lang: $lang, title: $title, latin: $latin, mtl: $mtl, main: $main)';
}


}

/// @nodoc
abstract mixin class _$VnReleaseLanguageCopyWith<$Res> implements $VnReleaseLanguageCopyWith<$Res> {
  factory _$VnReleaseLanguageCopyWith(_VnReleaseLanguage value, $Res Function(_VnReleaseLanguage) _then) = __$VnReleaseLanguageCopyWithImpl;
@override @useResult
$Res call({
 String lang, String? title, String? latin, bool mtl, bool main
});




}
/// @nodoc
class __$VnReleaseLanguageCopyWithImpl<$Res>
    implements _$VnReleaseLanguageCopyWith<$Res> {
  __$VnReleaseLanguageCopyWithImpl(this._self, this._then);

  final _VnReleaseLanguage _self;
  final $Res Function(_VnReleaseLanguage) _then;

/// Create a copy of VnReleaseLanguage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lang = null,Object? title = freezed,Object? latin = freezed,Object? mtl = null,Object? main = null,}) {
  return _then(_VnReleaseLanguage(
lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,latin: freezed == latin ? _self.latin : latin // ignore: cast_nullable_to_non_nullable
as String?,mtl: null == mtl ? _self.mtl : mtl // ignore: cast_nullable_to_non_nullable
as bool,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VnReleaseVn {

 String get id; String? get title; String? get rtype;
/// Create a copy of VnReleaseVn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnReleaseVnCopyWith<VnReleaseVn> get copyWith => _$VnReleaseVnCopyWithImpl<VnReleaseVn>(this as VnReleaseVn, _$identity);

  /// Serializes this VnReleaseVn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnReleaseVn&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.rtype, rtype) || other.rtype == rtype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,rtype);

@override
String toString() {
  return 'VnReleaseVn(id: $id, title: $title, rtype: $rtype)';
}


}

/// @nodoc
abstract mixin class $VnReleaseVnCopyWith<$Res>  {
  factory $VnReleaseVnCopyWith(VnReleaseVn value, $Res Function(VnReleaseVn) _then) = _$VnReleaseVnCopyWithImpl;
@useResult
$Res call({
 String id, String? title, String? rtype
});




}
/// @nodoc
class _$VnReleaseVnCopyWithImpl<$Res>
    implements $VnReleaseVnCopyWith<$Res> {
  _$VnReleaseVnCopyWithImpl(this._self, this._then);

  final VnReleaseVn _self;
  final $Res Function(VnReleaseVn) _then;

/// Create a copy of VnReleaseVn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? rtype = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,rtype: freezed == rtype ? _self.rtype : rtype // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VnReleaseVn].
extension VnReleaseVnPatterns on VnReleaseVn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnReleaseVn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnReleaseVn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnReleaseVn value)  $default,){
final _that = this;
switch (_that) {
case _VnReleaseVn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnReleaseVn value)?  $default,){
final _that = this;
switch (_that) {
case _VnReleaseVn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? title,  String? rtype)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnReleaseVn() when $default != null:
return $default(_that.id,_that.title,_that.rtype);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? title,  String? rtype)  $default,) {final _that = this;
switch (_that) {
case _VnReleaseVn():
return $default(_that.id,_that.title,_that.rtype);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? title,  String? rtype)?  $default,) {final _that = this;
switch (_that) {
case _VnReleaseVn() when $default != null:
return $default(_that.id,_that.title,_that.rtype);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnReleaseVn implements VnReleaseVn {
  const _VnReleaseVn({required this.id, this.title, this.rtype});
  factory _VnReleaseVn.fromJson(Map<String, dynamic> json) => _$VnReleaseVnFromJson(json);

@override final  String id;
@override final  String? title;
@override final  String? rtype;

/// Create a copy of VnReleaseVn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnReleaseVnCopyWith<_VnReleaseVn> get copyWith => __$VnReleaseVnCopyWithImpl<_VnReleaseVn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnReleaseVnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnReleaseVn&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.rtype, rtype) || other.rtype == rtype));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,rtype);

@override
String toString() {
  return 'VnReleaseVn(id: $id, title: $title, rtype: $rtype)';
}


}

/// @nodoc
abstract mixin class _$VnReleaseVnCopyWith<$Res> implements $VnReleaseVnCopyWith<$Res> {
  factory _$VnReleaseVnCopyWith(_VnReleaseVn value, $Res Function(_VnReleaseVn) _then) = __$VnReleaseVnCopyWithImpl;
@override @useResult
$Res call({
 String id, String? title, String? rtype
});




}
/// @nodoc
class __$VnReleaseVnCopyWithImpl<$Res>
    implements _$VnReleaseVnCopyWith<$Res> {
  __$VnReleaseVnCopyWithImpl(this._self, this._then);

  final _VnReleaseVn _self;
  final $Res Function(_VnReleaseVn) _then;

/// Create a copy of VnReleaseVn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? rtype = freezed,}) {
  return _then(_VnReleaseVn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,rtype: freezed == rtype ? _self.rtype : rtype // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
