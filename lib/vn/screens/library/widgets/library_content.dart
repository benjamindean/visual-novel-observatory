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

class LibraryContent extends ConsumerStatefulWidget {
  const LibraryContent({super.key});

  @override
  ConsumerState<LibraryContent> createState() {
    return LibraryContentState();
  }
}

class LibraryContentState extends ConsumerState<LibraryContent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ref.read(ulistLabelsProvider.notifier).loadLabels();
      ref.read(userUlistProvider.notifier).ensureEntriesLoaded();
    });
  }

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
  Widget build(BuildContext context) {
    final labelsAsync = ref.watch(ulistLabelsProvider);
    final activeLabels = filterVisibleLibraryLabels(
      labelsAsync.value ?? const <VndbLabel>[],
    );
    final initialIndex = _initialIndexFor(activeLabels);
    final tabKey = ValueKey(activeLabels.map((label) => label.id).join(','));

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
            child: labelsAsync.when(
              data: (labels) {
                final dataLabels = filterVisibleLibraryLabels(labels);

                return LibraryDataView(
                  activeLabels: dataLabels,
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
                      onPressed: () => ref
                          .read(ulistLabelsProvider.notifier)
                          .loadLabels(forceRefresh: true),
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
