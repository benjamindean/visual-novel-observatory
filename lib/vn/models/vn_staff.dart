import 'package:freezed_annotation/freezed_annotation.dart';

part 'vn_staff.freezed.dart';
part 'vn_staff.g.dart';

@freezed
abstract class VnStaff with _$VnStaff {
  const factory VnStaff({
    required String id,
    required String name,
    String? original,
  }) = _VnStaff;

  factory VnStaff.fromJson(Map<String, dynamic> json) =>
      _$VnStaffFromJson(json);
}
