const double vndbContentSensitivityThreshold = 0.2;

enum VndbContentSensitivityReason {
  spoiler,
  sexual,
  violent,
}

List<VndbContentSensitivityReason> vndbContentSensitivityReasons({
  required double? sexual,
  required double? violence,
  required bool blurSexualContent,
  required bool blurViolentContent,
  bool hasSpoiler = false,
}) {
  final reasons = <VndbContentSensitivityReason>[];
  final hasSensitiveSexualContent =
      sexual != null && sexual > vndbContentSensitivityThreshold;
  final hasSensitiveViolentContent =
      violence != null && violence > vndbContentSensitivityThreshold;

  if (hasSpoiler) {
    reasons.add(VndbContentSensitivityReason.spoiler);
  }

  if (blurSexualContent && hasSensitiveSexualContent) {
    reasons.add(VndbContentSensitivityReason.sexual);
  }

  if (blurViolentContent && hasSensitiveViolentContent) {
    reasons.add(VndbContentSensitivityReason.violent);
  }

  return reasons;
}

bool isSensitiveVndbContent({
  required double? sexual,
  required double? violence,
  required bool blurSexualContent,
  required bool blurViolentContent,
}) {
  final reasons = vndbContentSensitivityReasons(
    sexual: sexual,
    violence: violence,
    blurSexualContent: blurSexualContent,
    blurViolentContent: blurViolentContent,
  );

  return reasons.isNotEmpty;
}

bool shouldBlurVndbContent({
  required double? sexual,
  required double? violence,
  required bool blurSexualContent,
  required bool blurViolentContent,
  bool isRevealed = false,
}) {
  final isSensitive = isSensitiveVndbContent(
    sexual: sexual,
    violence: violence,
    blurSexualContent: blurSexualContent,
    blurViolentContent: blurViolentContent,
  );

  return isSensitive && !isRevealed;
}
