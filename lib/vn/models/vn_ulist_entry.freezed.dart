// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_ulist_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnUlistEntry {

 String get id; int? get vote; List<int> get labels;
/// Create a copy of VnUlistEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnUlistEntryCopyWith<VnUlistEntry> get copyWith => _$VnUlistEntryCopyWithImpl<VnUlistEntry>(this as VnUlistEntry, _$identity);

  /// Serializes this VnUlistEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnUlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.vote, vote) || other.vote == vote)&&const DeepCollectionEquality().equals(other.labels, labels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vote,const DeepCollectionEquality().hash(labels));

@override
String toString() {
  return 'VnUlistEntry(id: $id, vote: $vote, labels: $labels)';
}


}

/// @nodoc
abstract mixin class $VnUlistEntryCopyWith<$Res>  {
  factory $VnUlistEntryCopyWith(VnUlistEntry value, $Res Function(VnUlistEntry) _then) = _$VnUlistEntryCopyWithImpl;
@useResult
$Res call({
 String id, int? vote, List<int> labels
});




}
/// @nodoc
class _$VnUlistEntryCopyWithImpl<$Res>
    implements $VnUlistEntryCopyWith<$Res> {
  _$VnUlistEntryCopyWithImpl(this._self, this._then);

  final VnUlistEntry _self;
  final $Res Function(VnUlistEntry) _then;

/// Create a copy of VnUlistEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vote = freezed,Object? labels = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vote: freezed == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as int?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [VnUlistEntry].
extension VnUlistEntryPatterns on VnUlistEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnUlistEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnUlistEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnUlistEntry value)  $default,){
final _that = this;
switch (_that) {
case _VnUlistEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnUlistEntry value)?  $default,){
final _that = this;
switch (_that) {
case _VnUlistEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int? vote,  List<int> labels)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnUlistEntry() when $default != null:
return $default(_that.id,_that.vote,_that.labels);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int? vote,  List<int> labels)  $default,) {final _that = this;
switch (_that) {
case _VnUlistEntry():
return $default(_that.id,_that.vote,_that.labels);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int? vote,  List<int> labels)?  $default,) {final _that = this;
switch (_that) {
case _VnUlistEntry() when $default != null:
return $default(_that.id,_that.vote,_that.labels);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnUlistEntry implements VnUlistEntry {
  const _VnUlistEntry({required this.id, this.vote, final  List<int> labels = const []}): _labels = labels;
  factory _VnUlistEntry.fromJson(Map<String, dynamic> json) => _$VnUlistEntryFromJson(json);

@override final  String id;
@override final  int? vote;
 final  List<int> _labels;
@override@JsonKey() List<int> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}


/// Create a copy of VnUlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnUlistEntryCopyWith<_VnUlistEntry> get copyWith => __$VnUlistEntryCopyWithImpl<_VnUlistEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnUlistEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnUlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.vote, vote) || other.vote == vote)&&const DeepCollectionEquality().equals(other._labels, _labels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vote,const DeepCollectionEquality().hash(_labels));

@override
String toString() {
  return 'VnUlistEntry(id: $id, vote: $vote, labels: $labels)';
}


}

/// @nodoc
abstract mixin class _$VnUlistEntryCopyWith<$Res> implements $VnUlistEntryCopyWith<$Res> {
  factory _$VnUlistEntryCopyWith(_VnUlistEntry value, $Res Function(_VnUlistEntry) _then) = __$VnUlistEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, int? vote, List<int> labels
});




}
/// @nodoc
class __$VnUlistEntryCopyWithImpl<$Res>
    implements _$VnUlistEntryCopyWith<$Res> {
  __$VnUlistEntryCopyWithImpl(this._self, this._then);

  final _VnUlistEntry _self;
  final $Res Function(_VnUlistEntry) _then;

/// Create a copy of VnUlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vote = freezed,Object? labels = null,}) {
  return _then(_VnUlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vote: freezed == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as int?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
