import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vn_providers.dart';
import '../../models/vndb_label.dart';
import '../../widgets/vn_card.dart';
import '../../widgets/app_settings_button.dart';
import '../../../theme/app_theme.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../core/storage/app_storage.dart';
import 'library_auth_placeholder.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    if (!authState.isAuthenticated) {
      return const LibraryAuthPlaceholder();
    }

    final labelsAsync = ref.watch(ulistLabelsProvider);
    final ulistState = ref.watch(userUlistProvider);

    final activeLabels = labelsAsync.value != null
        ? labelsAsync.value!
              .where((l) => l.label != null && l.label!.isNotEmpty)
              .where((l) => l.id != 0 && l.id != 7)
              .where(
                (l) =>
                    l.label!.toLowerCase() != 'no label' &&
                    l.label!.toLowerCase() != 'voted',
              )
              .toList()
        : const <VndbLabel>[];

    final lastLabelId =
        AppStorage.mainBox.get('settings_last_library_label_id') as int?;
    int initialIndex = 0;

    if (lastLabelId != null && activeLabels.isNotEmpty) {
      final savedIndex = activeLabels.indexWhere(
        (l) => l.id == lastLabelId,
      );

      if (savedIndex != -1) {
        initialIndex = savedIndex;
      }
    }

    return DefaultTabController(
      key: ValueKey(activeLabels.length),
      length: activeLabels.isEmpty ? 1 : activeLabels.length,
      initialIndex: initialIndex,
      child: TabChangeListener(
        activeLabels: activeLabels,
        child: Scaffold(
          body: SafeArea(
            bottom: false,
            child: labelsAsync.when(
              data: (labels) {
                if (activeLabels.isEmpty) {
                  return CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: false,
                        pinned: false,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: context.appBackground,
                        titleSpacing: 20,
                        centerTitle: false,
                        title: Text(
                          'Library',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        actions: const [
                          AppSettingsButton(),
                          SizedBox(width: 20),
                        ],
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No labels found.',
                            style: TextStyle(color: context.appTextMuted),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        floating: true,
                        snap: false,
                        pinned: false,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: context.appBackground,
                        titleSpacing: 20,
                        centerTitle: false,
                        title: Text(
                          'Library',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        actions: const [
                          AppSettingsButton(),
                          SizedBox(width: 20),
                        ],
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: activeLabels.map((label) {
                      final vns = ulistState.entries.values
                          .where((entry) => entry.labels.contains(label.id))
                          .where((entry) => entry.vn != null)
                          .map((entry) => entry.vn!)
                          .toList();

                      if (ulistState.isLoading && ulistState.entries.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: context.appAccentTeal,
                          ),
                        );
                      }

                      if (vns.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open_rounded,
                                  size: 64,
                                  color: context.appTextMuted,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Empty List',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.appTextPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No visual novels in "${label.label ?? ''}"',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: context.appTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => ref
                            .read(userUlistProvider.notifier)
                            .fetchAllEntries(),
                        color: context.appAccentTeal,
                        backgroundColor: context.appSurface,
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 2 / 3,
                              ),
                          itemCount: vns.length,
                          itemBuilder: (context, index) {
                            final vn = vns[index];

                            return VnCard(
                              vn: vn,
                              onTap: () {
                                context.push('/detail', extra: vn);
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
              loading: () => CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: false,
                    pinned: false,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: context.appBackground,
                    titleSpacing: 20,
                    centerTitle: false,
                    title: Text(
                      'Library',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    actions: const [
                      AppSettingsButton(),
                      SizedBox(width: 20),
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.appAccentTeal,
                      ),
                    ),
                  ),
                ],
              ),
              error: (err, stack) => CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: false,
                    pinned: false,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: context.appBackground,
                    titleSpacing: 20,
                    centerTitle: false,
                    title: Text(
                      'Library',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    actions: const [
                      AppSettingsButton(),
                      SizedBox(width: 20),
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
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
                            ButtonTheme(
                              minWidth: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.appAccentTeal,
                                  foregroundColor:
                                      context.colorScheme.onPrimary,
                                ),
                                onPressed: () =>
                                    ref.invalidate(ulistLabelsProvider),
                                child: const Text('Retry'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: activeLabels.isEmpty
              ? null
              : Builder(
                  builder: (context) {
                    return Material(
                      color: context.appSurface,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: context.appTextPrimary.withValues(
                                alpha: 0.08,
                              ),
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
                          tabs: activeLabels.map((label) {
                            final count = ulistState.entries.values
                                .where(
                                  (entry) => entry.labels.contains(label.id),
                                )
                                .where((entry) => entry.vn != null)
                                .length;

                            return Tab(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(label.label ?? ''),
                                    const SizedBox(width: 6),
                                    Container(
                                      height: 18,
                                      constraints: const BoxConstraints(
                                        minWidth: 18,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.appAccentTeal,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$count',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class TabChangeListener extends StatefulWidget {
  final List<VndbLabel> activeLabels;
  final Widget child;

  const TabChangeListener({
    super.key,
    required this.activeLabels,
    required this.child,
  });

  @override
  State<TabChangeListener> createState() => _TabChangeListenerState();
}

class _TabChangeListenerState extends State<TabChangeListener> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = DefaultTabController.of(context);

    if (_controller != newController) {
      _controller?.removeListener(_onTabChanged);
      _controller = newController;
      _controller?.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (_controller != null && !_controller!.indexIsChanging) {
      final index = _controller!.index;

      if (index >= 0 && index < widget.activeLabels.length) {
        final labelId = widget.activeLabels[index].id;

        AppStorage.mainBox.put('settings_last_library_label_id', labelId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
