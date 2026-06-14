import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_screenshot.freezed.dart';
part 'vn_screenshot.g.dart';

@freezed
abstract class VnScreenshot with _$VnScreenshot {
  const factory VnScreenshot({
    @Default('') String url,
    @Default([0, 0]) List<int> dims,
    String? thumbnail,
    double? sexual,
    double? violence,
  }) = _VnScreenshot;

  factory VnScreenshot.fromJson(Map<String, dynamic> json) =>
      _$VnScreenshotFromJson(json);
}
