// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_screenshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VnScreenshot _$VnScreenshotFromJson(Map<String, dynamic> json) =>
    _VnScreenshot(
      url: json['url'] as String? ?? '',
      dims:
          (json['dims'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [0, 0],
      thumbnail: json['thumbnail'] as String?,
      sexual: (json['sexual'] as num?)?.toDouble(),
      violence: (json['violence'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VnScreenshotToJson(_VnScreenshot instance) =>
    <String, dynamic>{
      'url': instance.url,
      'dims': instance.dims,
      'thumbnail': instance.thumbnail,
      'sexual': instance.sexual,
      'violence': instance.violence,
    };
