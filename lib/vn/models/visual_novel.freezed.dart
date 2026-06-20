// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visual_novel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisualNovel {

 String get id; String get title;@JsonKey(name: 'alttitle') String? get altTitle; List<VnTitle> get titles; String? get description; double? get average; double? get rating; int? get votecount; String? get imageUrl; List<int>? get imageDims; double? get imageSexual; double? get imageViolence; String? get released;@JsonKey(name: 'olang') String? get originalLanguage;@JsonKey(name: 'devstatus') int? get devStatus; int? get length;@JsonKey(name: 'length_minutes') int? get lengthMinutes;@JsonKey(name: 'length_votes') int? get lengthVotes; List<VnTag> get tags; List<VnDeveloper> get developers; List<VnScreenshot> get screenshots; List<String> get platforms; List<String> get languages; List<String> get aliases;@JsonKey(name: 'extlinks') List<VnExternalLink> get extLinks;@JsonKey(name: 'va') List<VnVoiceActorAssociation> get voiceActors; List<VnRelation> get relations;
/// Create a copy of VisualNovel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisualNovelCopyWith<VisualNovel> get copyWith => _$VisualNovelCopyWithImpl<VisualNovel>(this as VisualNovel, _$identity);

  /// Serializes this VisualNovel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualNovel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.altTitle, altTitle) || other.altTitle == altTitle)&&const DeepCollectionEquality().equals(other.titles, titles)&&(identical(other.description, description) || other.description == description)&&(identical(other.average, average) || other.average == average)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.votecount, votecount) || other.votecount == votecount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.imageDims, imageDims)&&(identical(other.imageSexual, imageSexual) || other.imageSexual == imageSexual)&&(identical(other.imageViolence, imageViolence) || other.imageViolence == imageViolence)&&(identical(other.released, released) || other.released == released)&&(identical(other.originalLanguage, originalLanguage) || other.originalLanguage == originalLanguage)&&(identical(other.devStatus, devStatus) || other.devStatus == devStatus)&&(identical(other.length, length) || other.length == length)&&(identical(other.lengthMinutes, lengthMinutes) || other.lengthMinutes == lengthMinutes)&&(identical(other.lengthVotes, lengthVotes) || other.lengthVotes == lengthVotes)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.developers, developers)&&const DeepCollectionEquality().equals(other.screenshots, screenshots)&&const DeepCollectionEquality().equals(other.platforms, platforms)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&const DeepCollectionEquality().equals(other.extLinks, extLinks)&&const DeepCollectionEquality().equals(other.voiceActors, voiceActors)&&const DeepCollectionEquality().equals(other.relations, relations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,altTitle,const DeepCollectionEquality().hash(titles),description,average,rating,votecount,imageUrl,const DeepCollectionEquality().hash(imageDims),imageSexual,imageViolence,released,originalLanguage,devStatus,length,lengthMinutes,lengthVotes,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(developers),const DeepCollectionEquality().hash(screenshots),const DeepCollectionEquality().hash(platforms),const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(aliases),const DeepCollectionEquality().hash(extLinks),const DeepCollectionEquality().hash(voiceActors),const DeepCollectionEquality().hash(relations)]);

@override
String toString() {
  return 'VisualNovel(id: $id, title: $title, altTitle: $altTitle, titles: $titles, description: $description, average: $average, rating: $rating, votecount: $votecount, imageUrl: $imageUrl, imageDims: $imageDims, imageSexual: $imageSexual, imageViolence: $imageViolence, released: $released, originalLanguage: $originalLanguage, devStatus: $devStatus, length: $length, lengthMinutes: $lengthMinutes, lengthVotes: $lengthVotes, tags: $tags, developers: $developers, screenshots: $screenshots, platforms: $platforms, languages: $languages, aliases: $aliases, extLinks: $extLinks, voiceActors: $voiceActors, relations: $relations)';
}


}

/// @nodoc
abstract mixin class $VisualNovelCopyWith<$Res>  {
  factory $VisualNovelCopyWith(VisualNovel value, $Res Function(VisualNovel) _then) = _$VisualNovelCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'alttitle') String? altTitle, List<VnTitle> titles, String? description, double? average, double? rating, int? votecount, String? imageUrl, List<int>? imageDims, double? imageSexual, double? imageViolence, String? released,@JsonKey(name: 'olang') String? originalLanguage,@JsonKey(name: 'devstatus') int? devStatus, int? length,@JsonKey(name: 'length_minutes') int? lengthMinutes,@JsonKey(name: 'length_votes') int? lengthVotes, List<VnTag> tags, List<VnDeveloper> developers, List<VnScreenshot> screenshots, List<String> platforms, List<String> languages, List<String> aliases,@JsonKey(name: 'extlinks') List<VnExternalLink> extLinks,@JsonKey(name: 'va') List<VnVoiceActorAssociation> voiceActors, List<VnRelation> relations
});




}
/// @nodoc
class _$VisualNovelCopyWithImpl<$Res>
    implements $VisualNovelCopyWith<$Res> {
  _$VisualNovelCopyWithImpl(this._self, this._then);

  final VisualNovel _self;
  final $Res Function(VisualNovel) _then;

/// Create a copy of VisualNovel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? altTitle = freezed,Object? titles = null,Object? description = freezed,Object? average = freezed,Object? rating = freezed,Object? votecount = freezed,Object? imageUrl = freezed,Object? imageDims = freezed,Object? imageSexual = freezed,Object? imageViolence = freezed,Object? released = freezed,Object? originalLanguage = freezed,Object? devStatus = freezed,Object? length = freezed,Object? lengthMinutes = freezed,Object? lengthVotes = freezed,Object? tags = null,Object? developers = null,Object? screenshots = null,Object? platforms = null,Object? languages = null,Object? aliases = null,Object? extLinks = null,Object? voiceActors = null,Object? relations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,altTitle: freezed == altTitle ? _self.altTitle : altTitle // ignore: cast_nullable_to_non_nullable
as String?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<VnTitle>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,votecount: freezed == votecount ? _self.votecount : votecount // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageDims: freezed == imageDims ? _self.imageDims : imageDims // ignore: cast_nullable_to_non_nullable
as List<int>?,imageSexual: freezed == imageSexual ? _self.imageSexual : imageSexual // ignore: cast_nullable_to_non_nullable
as double?,imageViolence: freezed == imageViolence ? _self.imageViolence : imageViolence // ignore: cast_nullable_to_non_nullable
as double?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,originalLanguage: freezed == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as String?,devStatus: freezed == devStatus ? _self.devStatus : devStatus // ignore: cast_nullable_to_non_nullable
as int?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,lengthMinutes: freezed == lengthMinutes ? _self.lengthMinutes : lengthMinutes // ignore: cast_nullable_to_non_nullable
as int?,lengthVotes: freezed == lengthVotes ? _self.lengthVotes : lengthVotes // ignore: cast_nullable_to_non_nullable
as int?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<VnTag>,developers: null == developers ? _self.developers : developers // ignore: cast_nullable_to_non_nullable
as List<VnDeveloper>,screenshots: null == screenshots ? _self.screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<VnScreenshot>,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,extLinks: null == extLinks ? _self.extLinks : extLinks // ignore: cast_nullable_to_non_nullable
as List<VnExternalLink>,voiceActors: null == voiceActors ? _self.voiceActors : voiceActors // ignore: cast_nullable_to_non_nullable
as List<VnVoiceActorAssociation>,relations: null == relations ? _self.relations : relations // ignore: cast_nullable_to_non_nullable
as List<VnRelation>,
  ));
}

}


/// Adds pattern-matching-related methods to [VisualNovel].
extension VisualNovelPatterns on VisualNovel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisualNovel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisualNovel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisualNovel value)  $default,){
final _that = this;
switch (_that) {
case _VisualNovel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisualNovel value)?  $default,){
final _that = this;
switch (_that) {
case _VisualNovel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  List<VnTitle> titles,  String? description,  double? average,  double? rating,  int? votecount,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  String? released, @JsonKey(name: 'olang')  String? originalLanguage, @JsonKey(name: 'devstatus')  int? devStatus,  int? length, @JsonKey(name: 'length_minutes')  int? lengthMinutes, @JsonKey(name: 'length_votes')  int? lengthVotes,  List<VnTag> tags,  List<VnDeveloper> developers,  List<VnScreenshot> screenshots,  List<String> platforms,  List<String> languages,  List<String> aliases, @JsonKey(name: 'extlinks')  List<VnExternalLink> extLinks, @JsonKey(name: 'va')  List<VnVoiceActorAssociation> voiceActors,  List<VnRelation> relations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisualNovel() when $default != null:
return $default(_that.id,_that.title,_that.altTitle,_that.titles,_that.description,_that.average,_that.rating,_that.votecount,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.released,_that.originalLanguage,_that.devStatus,_that.length,_that.lengthMinutes,_that.lengthVotes,_that.tags,_that.developers,_that.screenshots,_that.platforms,_that.languages,_that.aliases,_that.extLinks,_that.voiceActors,_that.relations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  List<VnTitle> titles,  String? description,  double? average,  double? rating,  int? votecount,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  String? released, @JsonKey(name: 'olang')  String? originalLanguage, @JsonKey(name: 'devstatus')  int? devStatus,  int? length, @JsonKey(name: 'length_minutes')  int? lengthMinutes, @JsonKey(name: 'length_votes')  int? lengthVotes,  List<VnTag> tags,  List<VnDeveloper> developers,  List<VnScreenshot> screenshots,  List<String> platforms,  List<String> languages,  List<String> aliases, @JsonKey(name: 'extlinks')  List<VnExternalLink> extLinks, @JsonKey(name: 'va')  List<VnVoiceActorAssociation> voiceActors,  List<VnRelation> relations)  $default,) {final _that = this;
switch (_that) {
case _VisualNovel():
return $default(_that.id,_that.title,_that.altTitle,_that.titles,_that.description,_that.average,_that.rating,_that.votecount,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.released,_that.originalLanguage,_that.devStatus,_that.length,_that.lengthMinutes,_that.lengthVotes,_that.tags,_that.developers,_that.screenshots,_that.platforms,_that.languages,_that.aliases,_that.extLinks,_that.voiceActors,_that.relations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'alttitle')  String? altTitle,  List<VnTitle> titles,  String? description,  double? average,  double? rating,  int? votecount,  String? imageUrl,  List<int>? imageDims,  double? imageSexual,  double? imageViolence,  String? released, @JsonKey(name: 'olang')  String? originalLanguage, @JsonKey(name: 'devstatus')  int? devStatus,  int? length, @JsonKey(name: 'length_minutes')  int? lengthMinutes, @JsonKey(name: 'length_votes')  int? lengthVotes,  List<VnTag> tags,  List<VnDeveloper> developers,  List<VnScreenshot> screenshots,  List<String> platforms,  List<String> languages,  List<String> aliases, @JsonKey(name: 'extlinks')  List<VnExternalLink> extLinks, @JsonKey(name: 'va')  List<VnVoiceActorAssociation> voiceActors,  List<VnRelation> relations)?  $default,) {final _that = this;
switch (_that) {
case _VisualNovel() when $default != null:
return $default(_that.id,_that.title,_that.altTitle,_that.titles,_that.description,_that.average,_that.rating,_that.votecount,_that.imageUrl,_that.imageDims,_that.imageSexual,_that.imageViolence,_that.released,_that.originalLanguage,_that.devStatus,_that.length,_that.lengthMinutes,_that.lengthVotes,_that.tags,_that.developers,_that.screenshots,_that.platforms,_that.languages,_that.aliases,_that.extLinks,_that.voiceActors,_that.relations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisualNovel extends VisualNovel {
  const _VisualNovel({required this.id, required this.title, @JsonKey(name: 'alttitle') this.altTitle, final  List<VnTitle> titles = const [], this.description, this.average, this.rating, this.votecount, this.imageUrl, final  List<int>? imageDims, this.imageSexual, this.imageViolence, this.released, @JsonKey(name: 'olang') this.originalLanguage, @JsonKey(name: 'devstatus') this.devStatus, this.length, @JsonKey(name: 'length_minutes') this.lengthMinutes, @JsonKey(name: 'length_votes') this.lengthVotes, final  List<VnTag> tags = const [], final  List<VnDeveloper> developers = const [], final  List<VnScreenshot> screenshots = const [], final  List<String> platforms = const [], final  List<String> languages = const [], final  List<String> aliases = const [], @JsonKey(name: 'extlinks') final  List<VnExternalLink> extLinks = const [], @JsonKey(name: 'va') final  List<VnVoiceActorAssociation> voiceActors = const [], final  List<VnRelation> relations = const []}): _titles = titles,_imageDims = imageDims,_tags = tags,_developers = developers,_screenshots = screenshots,_platforms = platforms,_languages = languages,_aliases = aliases,_extLinks = extLinks,_voiceActors = voiceActors,_relations = relations,super._();
  factory _VisualNovel.fromJson(Map<String, dynamic> json) => _$VisualNovelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'alttitle') final  String? altTitle;
 final  List<VnTitle> _titles;
@override@JsonKey() List<VnTitle> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

@override final  String? description;
@override final  double? average;
@override final  double? rating;
@override final  int? votecount;
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
@override final  String? released;
@override@JsonKey(name: 'olang') final  String? originalLanguage;
@override@JsonKey(name: 'devstatus') final  int? devStatus;
@override final  int? length;
@override@JsonKey(name: 'length_minutes') final  int? lengthMinutes;
@override@JsonKey(name: 'length_votes') final  int? lengthVotes;
 final  List<VnTag> _tags;
@override@JsonKey() List<VnTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<VnDeveloper> _developers;
@override@JsonKey() List<VnDeveloper> get developers {
  if (_developers is EqualUnmodifiableListView) return _developers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_developers);
}

 final  List<VnScreenshot> _screenshots;
@override@JsonKey() List<VnScreenshot> get screenshots {
  if (_screenshots is EqualUnmodifiableListView) return _screenshots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenshots);
}

 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<String> _aliases;
@override@JsonKey() List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}

 final  List<VnExternalLink> _extLinks;
@override@JsonKey(name: 'extlinks') List<VnExternalLink> get extLinks {
  if (_extLinks is EqualUnmodifiableListView) return _extLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extLinks);
}

 final  List<VnVoiceActorAssociation> _voiceActors;
@override@JsonKey(name: 'va') List<VnVoiceActorAssociation> get voiceActors {
  if (_voiceActors is EqualUnmodifiableListView) return _voiceActors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voiceActors);
}

 final  List<VnRelation> _relations;
@override@JsonKey() List<VnRelation> get relations {
  if (_relations is EqualUnmodifiableListView) return _relations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relations);
}


/// Create a copy of VisualNovel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisualNovelCopyWith<_VisualNovel> get copyWith => __$VisualNovelCopyWithImpl<_VisualNovel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisualNovelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisualNovel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.altTitle, altTitle) || other.altTitle == altTitle)&&const DeepCollectionEquality().equals(other._titles, _titles)&&(identical(other.description, description) || other.description == description)&&(identical(other.average, average) || other.average == average)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.votecount, votecount) || other.votecount == votecount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._imageDims, _imageDims)&&(identical(other.imageSexual, imageSexual) || other.imageSexual == imageSexual)&&(identical(other.imageViolence, imageViolence) || other.imageViolence == imageViolence)&&(identical(other.released, released) || other.released == released)&&(identical(other.originalLanguage, originalLanguage) || other.originalLanguage == originalLanguage)&&(identical(other.devStatus, devStatus) || other.devStatus == devStatus)&&(identical(other.length, length) || other.length == length)&&(identical(other.lengthMinutes, lengthMinutes) || other.lengthMinutes == lengthMinutes)&&(identical(other.lengthVotes, lengthVotes) || other.lengthVotes == lengthVotes)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._developers, _developers)&&const DeepCollectionEquality().equals(other._screenshots, _screenshots)&&const DeepCollectionEquality().equals(other._platforms, _platforms)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&const DeepCollectionEquality().equals(other._extLinks, _extLinks)&&const DeepCollectionEquality().equals(other._voiceActors, _voiceActors)&&const DeepCollectionEquality().equals(other._relations, _relations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,altTitle,const DeepCollectionEquality().hash(_titles),description,average,rating,votecount,imageUrl,const DeepCollectionEquality().hash(_imageDims),imageSexual,imageViolence,released,originalLanguage,devStatus,length,lengthMinutes,lengthVotes,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_developers),const DeepCollectionEquality().hash(_screenshots),const DeepCollectionEquality().hash(_platforms),const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_aliases),const DeepCollectionEquality().hash(_extLinks),const DeepCollectionEquality().hash(_voiceActors),const DeepCollectionEquality().hash(_relations)]);

@override
String toString() {
  return 'VisualNovel(id: $id, title: $title, altTitle: $altTitle, titles: $titles, description: $description, average: $average, rating: $rating, votecount: $votecount, imageUrl: $imageUrl, imageDims: $imageDims, imageSexual: $imageSexual, imageViolence: $imageViolence, released: $released, originalLanguage: $originalLanguage, devStatus: $devStatus, length: $length, lengthMinutes: $lengthMinutes, lengthVotes: $lengthVotes, tags: $tags, developers: $developers, screenshots: $screenshots, platforms: $platforms, languages: $languages, aliases: $aliases, extLinks: $extLinks, voiceActors: $voiceActors, relations: $relations)';
}


}

/// @nodoc
abstract mixin class _$VisualNovelCopyWith<$Res> implements $VisualNovelCopyWith<$Res> {
  factory _$VisualNovelCopyWith(_VisualNovel value, $Res Function(_VisualNovel) _then) = __$VisualNovelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'alttitle') String? altTitle, List<VnTitle> titles, String? description, double? average, double? rating, int? votecount, String? imageUrl, List<int>? imageDims, double? imageSexual, double? imageViolence, String? released,@JsonKey(name: 'olang') String? originalLanguage,@JsonKey(name: 'devstatus') int? devStatus, int? length,@JsonKey(name: 'length_minutes') int? lengthMinutes,@JsonKey(name: 'length_votes') int? lengthVotes, List<VnTag> tags, List<VnDeveloper> developers, List<VnScreenshot> screenshots, List<String> platforms, List<String> languages, List<String> aliases,@JsonKey(name: 'extlinks') List<VnExternalLink> extLinks,@JsonKey(name: 'va') List<VnVoiceActorAssociation> voiceActors, List<VnRelation> relations
});




}
/// @nodoc
class __$VisualNovelCopyWithImpl<$Res>
    implements _$VisualNovelCopyWith<$Res> {
  __$VisualNovelCopyWithImpl(this._self, this._then);

  final _VisualNovel _self;
  final $Res Function(_VisualNovel) _then;

/// Create a copy of VisualNovel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? altTitle = freezed,Object? titles = null,Object? description = freezed,Object? average = freezed,Object? rating = freezed,Object? votecount = freezed,Object? imageUrl = freezed,Object? imageDims = freezed,Object? imageSexual = freezed,Object? imageViolence = freezed,Object? released = freezed,Object? originalLanguage = freezed,Object? devStatus = freezed,Object? length = freezed,Object? lengthMinutes = freezed,Object? lengthVotes = freezed,Object? tags = null,Object? developers = null,Object? screenshots = null,Object? platforms = null,Object? languages = null,Object? aliases = null,Object? extLinks = null,Object? voiceActors = null,Object? relations = null,}) {
  return _then(_VisualNovel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,altTitle: freezed == altTitle ? _self.altTitle : altTitle // ignore: cast_nullable_to_non_nullable
as String?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<VnTitle>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,votecount: freezed == votecount ? _self.votecount : votecount // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageDims: freezed == imageDims ? _self._imageDims : imageDims // ignore: cast_nullable_to_non_nullable
as List<int>?,imageSexual: freezed == imageSexual ? _self.imageSexual : imageSexual // ignore: cast_nullable_to_non_nullable
as double?,imageViolence: freezed == imageViolence ? _self.imageViolence : imageViolence // ignore: cast_nullable_to_non_nullable
as double?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,originalLanguage: freezed == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as String?,devStatus: freezed == devStatus ? _self.devStatus : devStatus // ignore: cast_nullable_to_non_nullable
as int?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,lengthMinutes: freezed == lengthMinutes ? _self.lengthMinutes : lengthMinutes // ignore: cast_nullable_to_non_nullable
as int?,lengthVotes: freezed == lengthVotes ? _self.lengthVotes : lengthVotes // ignore: cast_nullable_to_non_nullable
as int?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<VnTag>,developers: null == developers ? _self._developers : developers // ignore: cast_nullable_to_non_nullable
as List<VnDeveloper>,screenshots: null == screenshots ? _self._screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<VnScreenshot>,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,extLinks: null == extLinks ? _self._extLinks : extLinks // ignore: cast_nullable_to_non_nullable
as List<VnExternalLink>,voiceActors: null == voiceActors ? _self._voiceActors : voiceActors // ignore: cast_nullable_to_non_nullable
as List<VnVoiceActorAssociation>,relations: null == relations ? _self._relations : relations // ignore: cast_nullable_to_non_nullable
as List<VnRelation>,
  ));
}


}


/// @nodoc
mixin _$VnTitle {

 String get lang; String get title; String? get latin; bool get official; bool get main;
/// Create a copy of VnTitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VnTitleCopyWith<VnTitle> get copyWith => _$VnTitleCopyWithImpl<VnTitle>(this as VnTitle, _$identity);

  /// Serializes this VnTitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VnTitle&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.latin, latin) || other.latin == latin)&&(identical(other.official, official) || other.official == official)&&(identical(other.main, main) || other.main == main));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,title,latin,official,main);

@override
String toString() {
  return 'VnTitle(lang: $lang, title: $title, latin: $latin, official: $official, main: $main)';
}


}

/// @nodoc
abstract mixin class $VnTitleCopyWith<$Res>  {
  factory $VnTitleCopyWith(VnTitle value, $Res Function(VnTitle) _then) = _$VnTitleCopyWithImpl;
@useResult
$Res call({
 String lang, String title, String? latin, bool official, bool main
});




}
/// @nodoc
class _$VnTitleCopyWithImpl<$Res>
    implements $VnTitleCopyWith<$Res> {
  _$VnTitleCopyWithImpl(this._self, this._then);

  final VnTitle _self;
  final $Res Function(VnTitle) _then;

/// Create a copy of VnTitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lang = null,Object? title = null,Object? latin = freezed,Object? official = null,Object? main = null,}) {
  return _then(_self.copyWith(
lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,latin: freezed == latin ? _self.latin : latin // ignore: cast_nullable_to_non_nullable
as String?,official: null == official ? _self.official : official // ignore: cast_nullable_to_non_nullable
as bool,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VnTitle].
extension VnTitlePatterns on VnTitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VnTitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VnTitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VnTitle value)  $default,){
final _that = this;
switch (_that) {
case _VnTitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VnTitle value)?  $default,){
final _that = this;
switch (_that) {
case _VnTitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lang,  String title,  String? latin,  bool official,  bool main)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VnTitle() when $default != null:
return $default(_that.lang,_that.title,_that.latin,_that.official,_that.main);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lang,  String title,  String? latin,  bool official,  bool main)  $default,) {final _that = this;
switch (_that) {
case _VnTitle():
return $default(_that.lang,_that.title,_that.latin,_that.official,_that.main);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lang,  String title,  String? latin,  bool official,  bool main)?  $default,) {final _that = this;
switch (_that) {
case _VnTitle() when $default != null:
return $default(_that.lang,_that.title,_that.latin,_that.official,_that.main);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VnTitle implements VnTitle {
  const _VnTitle({required this.lang, required this.title, this.latin, this.official = false, this.main = false});
  factory _VnTitle.fromJson(Map<String, dynamic> json) => _$VnTitleFromJson(json);

@override final  String lang;
@override final  String title;
@override final  String? latin;
@override@JsonKey() final  bool official;
@override@JsonKey() final  bool main;

/// Create a copy of VnTitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VnTitleCopyWith<_VnTitle> get copyWith => __$VnTitleCopyWithImpl<_VnTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VnTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VnTitle&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.latin, latin) || other.latin == latin)&&(identical(other.official, official) || other.official == official)&&(identical(other.main, main) || other.main == main));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,title,latin,official,main);

@override
String toString() {
  return 'VnTitle(lang: $lang, title: $title, latin: $latin, official: $official, main: $main)';
}


}

/// @nodoc
abstract mixin class _$VnTitleCopyWith<$Res> implements $VnTitleCopyWith<$Res> {
  factory _$VnTitleCopyWith(_VnTitle value, $Res Function(_VnTitle) _then) = __$VnTitleCopyWithImpl;
@override @useResult
$Res call({
 String lang, String title, String? latin, bool official, bool main
});




}
/// @nodoc
class __$VnTitleCopyWithImpl<$Res>
    implements _$VnTitleCopyWith<$Res> {
  __$VnTitleCopyWithImpl(this._self, this._then);

  final _VnTitle _self;
  final $Res Function(_VnTitle) _then;

/// Create a copy of VnTitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lang = null,Object? title = null,Object? latin = freezed,Object? official = null,Object? main = null,}) {
  return _then(_VnTitle(
lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,latin: freezed == latin ? _self.latin : latin // ignore: cast_nullable_to_non_nullable
as String?,official: null == official ? _self.official : official // ignore: cast_nullable_to_non_nullable
as bool,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
