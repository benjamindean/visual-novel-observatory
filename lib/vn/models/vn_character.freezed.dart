// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vn_character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VnCharacter {

 String get id; String get name; String? get original; String? get description; List<String?>? get gender;@JsonKey(name: 'blood_type') String? get bloodType; List<int?>? get birthday; int? get height; int? get weight; int? get bust; int? get waist; int? get hips; String? get cup; dynamic get age; String? get imageUrl; List<int>? get imageDims; double? get imageSexual; double? get imageViolence; List<VnCharacterTrait> get traits;
/// Create a copy of VnCharacter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnCharacterCopyWith<VnCharacter> get copyWith => _$VnCharacterCopyWithImpl<VnCharacter>(this as VnCharacter, _$identity);

  /// Serializes this VnCharacter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnCharacter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.original, original) || other.original == original)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.gender, gender)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&const DeepCollectionEquality().equals(other.birthday, birthday)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bust, bust) || other.bust == bust)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.cup, cup) || other.cup == cup)&&const DeepCollectionEquality().equals(other.age, age)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.imageDims, imageDims)&&(identical(other.imageSexual, imageSexual) || other.imageSexual == imageSexual)&&(identical(other.imageViolence, imageViolence) || other.imageViolence == imageViolence)&&const DeepCollectionEquality().equals(other.traits, traits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,original,description,const DeepCollectionEquality().hash(gender),bloodType,const DeepCollectionEquality().hash(birthday),height,weight,bust,waist,hips,cup,const DeepCollectionEquality().hash(age),imageUrl,const DeepCollectionEquality().hash(imageDims),imageSexual,imageViolence,const DeepCollectionEquality().hash(traits)]);

@override
String toString() {
  return 'VnCharacter(id: $id, name: $name, original: $original, description: $description, gender: $gender, bloodType: $bloodType, birthday: $birthday, height: $height, weight: $weight, bust: $bust, waist: $waist, hips: $hips, cup: $cup, age: $age, imageUrl: $imageUrl, imageDims: $imageDims, imageSexual: $imageSexual, imageViolence: $imageViolence, traits: $traits)';
}


}

/// @nodoc
abstract mixin class $VnCharacterCopyWith<$Res>  {
  factory $VnCharacterCopyWith(VnCharacter value, $Res Function(VnCharacter) _then) = _$VnCharacterCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? original, String? description, List<String?>? gender,@JsonKey(name: 'blood_type') String? bloodType, List<int?>? birthday, int? height, int? weight, int? bust, int? waist, int? hips, String? cup, dynamic age, String? imageUrl, List<int>? imageDims, double? imageSexual, double? imageViolence, List<VnCharacterTrait> traits
});




}
/// @nodoc
class _$VnCharacterCopyWithImpl<$Res>
    implements $VnCharacterCopyWith<$Res> {
  _$VnCharacterCopyWithImpl(this._self, this._then);

  final VnCharacter _self;
  final $Res Function(VnCharacter) _then;

/// Create a copy of VnCharacter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? original = freezed,Object? description = freezed,Object? gender = freezed,Object? bloodType = freezed,Object? birthday = freezed,Object? height = freezed,Object? weight = freezed,Object? bust = freezed,Object? waist = freezed,Object? hips = freezed,Object? cup = freezed,Object? age = freezed,Object? imageUrl = freezed,Object? imageDims = freezed,Object? imageSexual = freezed,Object? imageViolence = freezed,Object? traits = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as List<String?>?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as List<int?>?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,bust: freezed == bust ? _self.bust : bust // ignore: cast_nullable_to_non_nullable
as int?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as int?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as int?,cup: freezed == cup ? _self.cup : cup // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageDims: freezed == imageDims ? _self.imageDims : imageDims // ignore: cast_nullable_to_non_nullable
as List<int>?,imageSexual: freezed == imageSexual ? _self.imageSexual : imageSexual // ignore: cast_nullable_to_non_nullable
as double?,imageViolence: freezed == imageViolence ? _self.imageViolence : imageViolence // ignore: cast_nullable_to_non_nullable
as double?,traits: null == traits ? _self.traits : traits // ignore: cast_nullable_to_non_nullable
as List<VnCharacterTrait>,
  ));
}

}


/// Adds pattern-matching-related methods to [VnCharacter].
extension VnCharacterPatterns on VnCharacter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnCharacter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnCharacter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnCharacter value)  $default,){
final _that = this;
switch (_that) {
case _VnCharacter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnCharacter value)?  $default,){
final _that = this;
switch (_that) {
case _VnCharacter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? original,  String? description,  List<String?>? gender, @JsonKey(name: 'blood_type')  String? bloodType,  List<int?>? birthday,  int? height,  int? weight,  int? bust,  int? waist,  int? hips,  String? cup,  dynamic age,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  List<VnCharacterTrait> traits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnCharacter() when $default != null:
return $default(_that.id,_that.name,_that.original,_that.description,_that.gender,_that.bloodType,_that.birthday,_that.height,_that.weight,_that.bust,_that.waist,_that.hips,_that.cup,_that.age,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.traits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? original,  String? description,  List<String?>? gender, @JsonKey(name: 'blood_type')  String? bloodType,  List<int?>? birthday,  int? height,  int? weight,  int? bust,  int? waist,  int? hips,  String? cup,  dynamic age,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  List<VnCharacterTrait> traits)  $default,) {final _that = this;
switch (_that) {
case _VnCharacter():
return $default(_that.id,_that.name,_that.original,_that.description,_that.gender,_that.bloodType,_that.birthday,_that.height,_that.weight,_that.bust,_that.waist,_that.hips,_that.cup,_that.age,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.traits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? original,  String? description,  List<String?>? gender, @JsonKey(name: 'blood_type')  String? bloodType,  List<int?>? birthday,  int? height,  int? weight,  int? bust,  int? waist,  int? hips,  String? cup,  dynamic age,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  List<VnCharacterTrait> traits)?  $default,) {final _that = this;
switch (_that) {
case _VnCharacter() when $default != null:
return $default(_that.id,_that.name,_that.original,_that.description,_that.gender,_that.bloodType,_that.birthday,_that.height,_that.weight,_that.bust,_that.waist,_that.hips,_that.cup,_that.age,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.traits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnCharacter extends VnCharacter {
  const _VnCharacter({required this.id, required this.name, this.original, this.description, final  List<String?>? gender, @JsonKey(name: 'blood_type') this.bloodType, final  List<int?>? birthday, this.height, this.weight, this.bust, this.waist, this.hips, this.cup, this.age, this.imageUrl, final  List<int>? imageDims, this.imageSexual, this.imageViolence, final  List<VnCharacterTrait> traits = const []}): _gender = gender,_birthday = birthday,_imageDims = imageDims,_traits = traits,super._();
  factory _VnCharacter.fromJson(Map<String, dynamic> json) => _$VnCharacterFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? original;
@override final  String? description;
 final  List<String?>? _gender;
@override List<String?>? get gender {
  final value = _gender;
  if (value == null) return null;
  if (_gender is EqualUnmodifiableListView) return _gender;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'blood_type') final  String? bloodType;
 final  List<int?>? _birthday;
@override List<int?>? get birthday {
  final value = _birthday;
  if (value == null) return null;
  if (_birthday is EqualUnmodifiableListView) return _birthday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? height;
@override final  int? weight;
@override final  int? bust;
@override final  int? waist;
@override final  int? hips;
@override final  String? cup;
@override final  dynamic age;
@override final  String? imageUrl;
 final  List<int>? _imageDims;
@override List<int>? get imageDims {
  final value = _imageDims;
  if (value == null) return null;
  if (_imageDims is EqualUnmodifiableListView) return _imageDims;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? imageSexual;
@override final  double? imageViolence;
 final  List<VnCharacterTrait> _traits;
@override@JsonKey() List<VnCharacterTrait> get traits {
  if (_traits is EqualUnmodifiableListView) return _traits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_traits);
}


/// Create a copy of VnCharacter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnCharacterCopyWith<_VnCharacter> get copyWith => __$VnCharacterCopyWithImpl<_VnCharacter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnCharacterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnCharacter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.original, original) || other.original == original)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._gender, _gender)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&const DeepCollectionEquality().equals(other._birthday, _birthday)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bust, bust) || other.bust == bust)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.cup, cup) || other.cup == cup)&&const DeepCollectionEquality().equals(other.age, age)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._imageDims, _imageDims)&&(identical(other.imageSexual, imageSexual) || other.imageSexual == imageSexual)&&(identical(other.imageViolence, imageViolence) || other.imageViolence == imageViolence)&&const DeepCollectionEquality().equals(other._traits, _traits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,original,description,const DeepCollectionEquality().hash(_gender),bloodType,const DeepCollectionEquality().hash(_birthday),height,weight,bust,waist,hips,cup,const DeepCollectionEquality().hash(age),imageUrl,const DeepCollectionEquality().hash(_imageDims),imageSexual,imageViolence,const DeepCollectionEquality().hash(_traits)]);

@override
String toString() {
  return 'VnCharacter(id: $id, name: $name, original: $original, description: $description, gender: $gender, bloodType: $bloodType, birthday: $birthday, height: $height, weight: $weight, bust: $bust, waist: $waist, hips: $hips, cup: $cup, age: $age, imageUrl: $imageUrl, imageDims: $imageDims, imageSexual: $imageSexual, imageViolence: $imageViolence, traits: $traits)';
}


}

/// @nodoc
abstract mixin class _$VnCharacterCopyWith<$Res> implements $VnCharacterCopyWith<$Res> {
  factory _$VnCharacterCopyWith(_VnCharacter value, $Res Function(_VnCharacter) _then) = __$VnCharacterCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? original, String? description, List<String?>? gender,@JsonKey(name: 'blood_type') String? bloodType, List<int?>? birthday, int? height, int? weight, int? bust, int? waist, int? hips, String? cup, dynamic age, String? imageUrl, List<int>? imageDims, double? imageSexual, double? imageViolence, List<VnCharacterTrait> traits
});




}
/// @nodoc
class __$VnCharacterCopyWithImpl<$Res>
    implements _$VnCharacterCopyWith<$Res> {
  __$VnCharacterCopyWithImpl(this._self, this._then);

  final _VnCharacter _self;
  final $Res Function(_VnCharacter) _then;

/// Create a copy of VnCharacter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? original = freezed,Object? description = freezed,Object? gender = freezed,Object? bloodType = freezed,Object? birthday = freezed,Object? height = freezed,Object? weight = freezed,Object? bust = freezed,Object? waist = freezed,Object? hips = freezed,Object? cup = freezed,Object? age = freezed,Object? imageUrl = freezed,Object? imageDims = freezed,Object? imageSexual = freezed,Object? imageViolence = freezed,Object? traits = null,}) {
  return _then(_VnCharacter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self._gender : gender // ignore: cast_nullable_to_non_nullable
as List<String?>?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self._birthday : birthday // ignore: cast_nullable_to_non_nullable
as List<int?>?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,bust: freezed == bust ? _self.bust : bust // ignore: cast_nullable_to_non_nullable
as int?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as int?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as int?,cup: freezed == cup ? _self.cup : cup // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as dynamic,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageDims: freezed == imageDims ? _self._imageDims : imageDims // ignore: cast_nullable_to_non_nullable
as List<int>?,imageSexual: freezed == imageSexual ? _self.imageSexual : imageSexual // ignore: cast_nullable_to_non_nullable
as double?,imageViolence: freezed == imageViolence ? _self.imageViolence : imageViolence // ignore: cast_nullable_to_non_nullable
as double?,traits: null == traits ? _self._traits : traits // ignore: cast_nullable_to_non_nullable
as List<VnCharacterTrait>,
  ));
}


}


/// @nodoc
mixin _$VnCharacterTrait {

 String get id; String get name; int get spoiler;
/// Create a copy of VnCharacterTrait
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnCharacterTraitCopyWith<VnCharacterTrait> get copyWith => _$VnCharacterTraitCopyWithImpl<VnCharacterTrait>(this as VnCharacterTrait, _$identity);

  /// Serializes this VnCharacterTrait to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnCharacterTrait&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.spoiler, spoiler) || other.spoiler == spoiler));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,spoiler);

@override
String toString() {
  return 'VnCharacterTrait(id: $id, name: $name, spoiler: $spoiler)';
}


}

/// @nodoc
abstract mixin class $VnCharacterTraitCopyWith<$Res>  {
  factory $VnCharacterTraitCopyWith(VnCharacterTrait value, $Res Function(VnCharacterTrait) _then) = _$VnCharacterTraitCopyWithImpl;
@useResult
$Res call({
 String id, String name, int spoiler
});




}
/// @nodoc
class _$VnCharacterTraitCopyWithImpl<$Res>
    implements $VnCharacterTraitCopyWith<$Res> {
  _$VnCharacterTraitCopyWithImpl(this._self, this._then);

  final VnCharacterTrait _self;
  final $Res Function(VnCharacterTrait) _then;

/// Create a copy of VnCharacterTrait
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? spoiler = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spoiler: null == spoiler ? _self.spoiler : spoiler // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VnCharacterTrait].
extension VnCharacterTraitPatterns on VnCharacterTrait {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnCharacterTrait value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnCharacterTrait() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnCharacterTrait value)  $default,){
final _that = this;
switch (_that) {
case _VnCharacterTrait():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnCharacterTrait value)?  $default,){
final _that = this;
switch (_that) {
case _VnCharacterTrait() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int spoiler)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnCharacterTrait() when $default != null:
return $default(_that.id,_that.name,_that.spoiler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int spoiler)  $default,) {final _that = this;
switch (_that) {
case _VnCharacterTrait():
return $default(_that.id,_that.name,_that.spoiler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int spoiler)?  $default,) {final _that = this;
switch (_that) {
case _VnCharacterTrait() when $default != null:
return $default(_that.id,_that.name,_that.spoiler);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnCharacterTrait implements VnCharacterTrait {
  const _VnCharacterTrait({required this.id, required this.name, required this.spoiler});
  factory _VnCharacterTrait.fromJson(Map<String, dynamic> json) => _$VnCharacterTraitFromJson(json);

@override final  String id;
@override final  String name;
@override final  int spoiler;

/// Create a copy of VnCharacterTrait
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnCharacterTraitCopyWith<_VnCharacterTrait> get copyWith => __$VnCharacterTraitCopyWithImpl<_VnCharacterTrait>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnCharacterTraitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnCharacterTrait&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.spoiler, spoiler) || other.spoiler == spoiler));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,spoiler);

@override
String toString() {
  return 'VnCharacterTrait(id: $id, name: $name, spoiler: $spoiler)';
}


}

/// @nodoc
abstract mixin class _$VnCharacterTraitCopyWith<$Res> implements $VnCharacterTraitCopyWith<$Res> {
  factory _$VnCharacterTraitCopyWith(_VnCharacterTrait value, $Res Function(_VnCharacterTrait) _then) = __$VnCharacterTraitCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int spoiler
});




}
/// @nodoc
class __$VnCharacterTraitCopyWithImpl<$Res>
    implements _$VnCharacterTraitCopyWith<$Res> {
  __$VnCharacterTraitCopyWithImpl(this._self, this._then);

  final _VnCharacterTrait _self;
  final $Res Function(_VnCharacterTrait) _then;

/// Create a copy of VnCharacterTrait
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? spoiler = null,}) {
  return _then(_VnCharacterTrait(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spoiler: null == spoiler ? _self.spoiler : spoiler // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
