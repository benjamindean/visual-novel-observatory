import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';
import 'library_bottom_tab_bar.dart';
import 'library_data_view.dart';
import 'library_label_utils.dart';
import 'library_status_scroll_view.dart';
import 'library_tab_change_listener.dart';

class LibraryContent extends ConsumerWidget {
  const LibraryContent({
    super.key,
    required this.nestedScrollViewKey,
    required this.outerScrollController,
  });

  final GlobalKey<NestedScrollViewState> nestedScrollViewKey;
  final ScrollController outerScrollController;

  int _initialIndexFor(List<VndbLabel> activeLabels) {
    final lastLabelId =
        AppStorage.mainBox.get('settings_last_library_label_id') as int?;

    if (lastLabelId == null || activeLabels.isEmpty) {
      return 0;
    }

    final savedIndex = activeLabels.indexWhere(
      (label) => label.id == lastLabelId,
    );

    return savedIndex == -1 ? 0 : savedIndex;
  }

  void _ensureActiveLabel(WidgetRef ref, List<VndbLabel> activeLabels) {
    if (activeLabels.isEmpty) {
      return;
    }

    final currentSelectedId = ref.read(activeLibraryTabIdProvider);
    final hasCurrentLabel = activeLabels.any(
      (label) => label.id == currentSelectedId,
    );

    if (currentSelectedId == null || !hasCurrentLabel) {
      final initialLabelId = activeLabels[_initialIndexFor(activeLabels)].id;

      Future.microtask(() {
        ref.read(activeLibraryTabIdProvider.notifier).update(initialLabelId);
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelsAsync = ref.watch(ulistLabelsProvider);
    final activeLabels = filterVisibleLibraryLabels(
      labelsAsync.value ?? const <VndbLabel>[],
    );
    final initialIndex = _initialIndexFor(activeLabels);
    final tabKey = ValueKey(activeLabels.map((label) => label.id).join(','));

    _ensureActiveLabel(ref, activeLabels);

    return DefaultTabController(
      key: tabKey,
      length: activeLabels.isEmpty ? 1 : activeLabels.length,
      initialIndex: initialIndex,
      child: LibraryTabChangeListener(
        activeLabels: activeLabels,
        child: Scaffold(
          body: SafeArea(
            bottom: false,
            child: labelsAsync.when(
              data: (labels) {
                final dataLabels = filterVisibleLibraryLabels(labels);

                return LibraryDataView(
                  activeLabels: dataLabels,
                  nestedScrollViewKey: nestedScrollViewKey,
                  outerScrollController: outerScrollController,
                );
              },
              loading: () => LibraryStatusScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.appAccentTeal,
                  ),
                ),
              ),
              error: (err, stack) => LibraryStatusScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: context.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(err.toString(), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appAccentTeal,
                        foregroundColor: context.colorScheme.onPrimary,
                      ),
                      onPressed: () => ref.invalidate(ulistLabelsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: activeLabels.isEmpty
              ? null
              : Builder(
                  builder: (context) {
                    return LibraryBottomTabBar(activeLabels: activeLabels);
                  },
                ),
        ),
      ),
    );
  }
}
