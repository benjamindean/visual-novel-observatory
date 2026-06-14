// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'vn_tag.dart';
import 'vn_developer.dart';
import 'vn_screenshot.dart';
import 'vn_external_link.dart';

part 'visual_novel.freezed.dart';
part 'visual_novel.g.dart';

@freezed
abstract class VisualNovel with _$VisualNovel {
  const VisualNovel._();

  const factory VisualNovel({
    required String id,
    required String title,
    @JsonKey(name: 'alttitle') String? altTitle,
    String? description,
    double? rating,
    int? votecount,
    String? imageUrl,
    List<int>? imageDims,
    double? imageSexual,
    double? imageViolence,
    String? released,
    int? length,
    @JsonKey(name: 'length_minutes') int? lengthMinutes,
    @Default([]) List<VnTag> tags,
    @Default([]) List<VnDeveloper> developers,
    @Default([]) List<VnScreenshot> screenshots,
    @Default([]) List<String> platforms,
    @Default([]) List<String> languages,
    @Default([]) List<String> aliases,
    @JsonKey(name: 'extlinks') @Default([]) List<VnExternalLink> extLinks,
  }) = _VisualNovel;

  factory VisualNovel.fromJson(Map<String, dynamic> json) =>
      _$VisualNovelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final adjustedJson = Map<String, dynamic>.from(json);

    // If it's already normalized (e.g. from local storage serialization),
    // then imageUrl will already be present, and we don't need to normalize again.
    if (json.containsKey('imageUrl')) {
      return adjustedJson;
    }

    // Parse nested image object from VNDB API response
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

    // Normalise rating from 10-100 scale to 1-10 scale
    double? parsedRating;

    final rawRating = json['rating'];

    if (rawRating != null) {
      parsedRating = (rawRating as num).toDouble() / 10.0;
    }

    adjustedJson['imageUrl'] = imgUrl;
    adjustedJson['imageDims'] = imgDims;
    adjustedJson['imageSexual'] = imgSexual;
    adjustedJson['imageViolence'] = imgViolence;
    adjustedJson['rating'] = parsedRating;

    return adjustedJson;
  }

  // Get play length readable category
  String get playLengthLabel {
    switch (length) {
      case 1:
        return 'Very Short (< 2 hours)';
      case 2:
        return 'Short (2 - 10 hours)';
      case 3:
        return 'Medium (10 - 30 hours)';
      case 4:
        return 'Long (30 - 50 hours)';
      case 5:
        return 'Very Long (> 50 hours)';
      default:
        return 'Unknown Length';
    }
  }

  // Helper to format release date
  String get releaseYear {
    if (released == null || released == 'TBA') {
      return 'TBA';
    }

    if (released!.length >= 4) {
      return released!.substring(0, 4);
    }

    return released!;
  }
}
