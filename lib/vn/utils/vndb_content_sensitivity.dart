const double vndbContentSensitivityThreshold = 0.2;

enum VndbContentSensitivityReason {
  spoiler,
  sexual,
  violent,
}

List<VndbContentSensitivityReason> vndbContentSensitivityReasons({
  required double? sexual,
  required double? violence,
  required bool showExplicitContent,
  required bool showViolentContent,
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

  if (!showExplicitContent && hasSensitiveSexualContent) {
    reasons.add(VndbContentSensitivityReason.sexual);
  }

  if (!showViolentContent && hasSensitiveViolentContent) {
    reasons.add(VndbContentSensitivityReason.violent);
  }

  return reasons;
}

bool isSensitiveVndbContent({
  required double? sexual,
  required double? violence,
  required bool showExplicitContent,
  required bool showViolentContent,
}) {
  final reasons = vndbContentSensitivityReasons(
    sexual: sexual,
    violence: violence,
    showExplicitContent: showExplicitContent,
    showViolentContent: showViolentContent,
  );

  return reasons.isNotEmpty;
}

bool shouldBlurVndbContent({
  required double? sexual,
  required double? violence,
  required bool showExplicitContent,
  required bool showViolentContent,
  bool isRevealed = false,
}) {
  final isSensitive = isSensitiveVndbContent(
    sexual: sexual,
    violence: violence,
    showExplicitContent: showExplicitContent,
    showViolentContent: showViolentContent,
  );

  return isSensitive && !isRevealed;
}
