import 'package:freezed_annotation/freezed_annotation.dart';

part 'vndb_label.freezed.dart';
part 'vndb_label.g.dart';

@freezed
abstract class VndbLabel with _$VndbLabel {
  const factory VndbLabel({required int id, required String label}) =
      _VndbLabel;

  factory VndbLabel.fromJson(Map<String, dynamic> json) =>
      _$VndbLabelFromJson(json);
}
