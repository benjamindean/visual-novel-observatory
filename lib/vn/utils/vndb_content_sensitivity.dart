const double vndbContentSensitivityThreshold = 0.2;

bool isSensitiveVndbContent({
  required double? sexual,
  required double? violence,
  required bool showExplicitContent,
  required bool showViolentContent,
}) {
  final hasSensitiveSexualContent =
      sexual != null && sexual > vndbContentSensitivityThreshold;
  final hasSensitiveViolentContent =
      violence != null && violence > vndbContentSensitivityThreshold;

  return (!showExplicitContent && hasSensitiveSexualContent) ||
      (!showViolentContent && hasSensitiveViolentContent);
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
