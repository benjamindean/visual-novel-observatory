import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';
import 'library_bottom_tab_bar.dart';
import 'library_data_view.dart';
import 'library_label_utils.dart';
import 'library_loading_view.dart';
import 'library_tab_change_listener.dart';

class LibraryContent extends ConsumerWidget {
  const LibraryContent({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelsAsync = ref.watch(ulistLabelsProvider);
    final isLoading = ref.watch(userUlistIsLoadingProvider);
    final activeLabels = filterVisibleLibraryLabels(
      labelsAsync,
    );
    final initialIndex = _initialIndexFor(activeLabels);
    final tabKey = ValueKey(activeLabels.map((label) => label.id).join(','));

    if (activeLabels.isEmpty && isLoading) {
      return const LibraryLoadingView();
    }

    return DefaultTabController(
      key: tabKey,
      length: activeLabels.isEmpty ? 1 : activeLabels.length,
      initialIndex: initialIndex,
      child: LibraryTabChangeListener(
        activeLabels: activeLabels,
        child: Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: LibraryDataView(
              activeLabels: activeLabels,
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
