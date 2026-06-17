import '../../../models/vndb_label.dart';

List<VndbLabel> filterVisibleLibraryLabels(List<VndbLabel> labels) {
  return labels
      .where((label) => label.label != null && label.label!.isNotEmpty)
      .where((label) => label.id != 0 && label.id != 7)
      .where((label) {
        final lowerLabel = label.label!.toLowerCase();

        return lowerLabel != 'no label' && lowerLabel != 'voted';
      })
      .toList();
}
