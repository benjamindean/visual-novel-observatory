import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_character.freezed.dart';
part 'vn_character.g.dart';

@freezed
abstract class VnCharacter with _$VnCharacter {
  const VnCharacter._();

  const factory VnCharacter({
    required String id,
    required String name,
    String? original,
    String? description,
    List<String?>? gender,
    @JsonKey(name: 'blood_type') String? bloodType,
    List<int?>? birthday,
    int? height,
    int? weight,
    int? bust,
    int? waist,
    int? hips,
    String? cup,
    dynamic age,
    String? imageUrl,
    List<int>? imageDims,
    double? imageSexual,
    double? imageViolence,
    @Default([]) List<VnCharacterTrait> traits,
  }) = _VnCharacter;

  factory VnCharacter.fromJson(Map<String, dynamic> json) =>
      _$VnCharacterFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final adjustedJson = Map<String, dynamic>.from(json);

    if (json.containsKey('imageUrl')) {
      return adjustedJson;
    }

    String? imgUrl;
    List<int>? imgDims;
    double? imgSexual;
    double? imgViolence;

    final imageJson = json['image'];

    if (imageJson != null && imageJson is Map<String, dynamic>) {
      imgUrl = imageJson['url'] as String?;
      imgSexual = (imageJson['sexual'] as num?)?.toDouble();
      imgViolence = (imageJson['violence'] as num?)?.toDouble();

      final dimsList = imageJson['dims'] as List?;

      if (dimsList != null) {
        imgDims = List<int>.from(dimsList);
      }
    }

    adjustedJson['imageUrl'] = imgUrl;
    adjustedJson['imageDims'] = imgDims;
    adjustedJson['imageSexual'] = imgSexual;
    adjustedJson['imageViolence'] = imgViolence;

    return adjustedJson;
  }

  String? get formattedGender {
    if (gender == null || gender!.isEmpty) {
      return null;
    }

    final val = gender![0];

    if (val == 'm') {
      return 'Male';
    }

    if (val == 'f') {
      return 'Female';
    }

    if (val == 'both') {
      return 'Both';
    }

    return val;
  }

  String? get formattedBloodType {
    if (bloodType == null) {
      return null;
    }

    return bloodType!.toUpperCase();
  }

  String? get formattedBirthday {
    if (birthday == null || birthday!.length < 2) {
      return null;
    }

    final m = birthday![0];
    final d = birthday![1];

    if (m == null || d == null) {
      return null;
    }

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    if (m >= 1 && m <= 12) {
      return '${months[m - 1]} $d';
    }

    return '$m/$d';
  }

  String? get formattedHeight => height != null ? '$height cm' : null;
  String? get formattedWeight => weight != null ? '$weight kg' : null;

  String? get formattedMeasurements {
    if (bust == null && waist == null && hips == null) {
      return null;
    }

    final b = bust != null ? '$bust' : '?';
    final w = waist != null ? '$waist' : '?';
    final h = hips != null ? '$hips' : '?';
    final c = cup != null ? ' ($cup)' : '';

    return '$b-$w-$h$c';
  }

  String? get formattedAge {
    if (age == null) {
      return null;
    }

    return age.toString();
  }
}

@freezed
abstract class VnCharacterTrait with _$VnCharacterTrait {
  const factory VnCharacterTrait({
    required String id,
    required String name,
    required int spoiler,
  }) = _VnCharacterTrait;

  factory VnCharacterTrait.fromJson(Map<String, dynamic> json) =>
      _$VnCharacterTraitFromJson(json);
}
