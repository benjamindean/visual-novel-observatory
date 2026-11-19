import 'package:material_ui/material_ui.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import 'library_label_tab.dart';

class LibraryBottomTabBar extends StatelessWidget {
  const LibraryBottomTabBar({
    super.key,
    required this.activeLabels,
  });

  final List<VndbLabel> activeLabels;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurface,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.appTextPrimary.withValues(alpha: 0.08),
              width: 1.0,
            ),
          ),
        ),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: context.appAccentTeal,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: context.appAccentTeal,
          unselectedLabelColor: context.appTextMuted,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          tabs: [
            for (final indexedLabel in activeLabels.indexed)
              LibraryLabelTab(
                label: indexedLabel.$2,
                index: indexedLabel.$1,
              ),
          ],
        ),
      ),
    );
  }
}
