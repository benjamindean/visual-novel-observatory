import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/vn_providers.dart';
import '../widgets/vn_card.dart';
import '../../theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          backgroundColor: context.appBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.library_books_rounded,
                  size: 64,
                  color: context.appTextMuted,
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Library',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Connect your VNDB profile to sync your visual novel list, votes, and playing status.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.appTextMuted,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appAccentTeal,
                    foregroundColor: context.colorScheme.onPrimary,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text(
                    'Connect VNDB Profile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final labelsAsync = ref.watch(ulistLabelsProvider);
    final ulistState = ref.watch(userUlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: labelsAsync.when(
        data: (labels) {
          if (labels.isEmpty) {
            return Center(
              child: Text(
                'No labels found.',
                style: TextStyle(color: context.appTextMuted),
              ),
            );
          }

          final activeLabels = labels
              .where((l) => l.label != null && l.label!.isNotEmpty)
              .toList();

          return DefaultTabController(
            length: activeLabels.length,
            child: Scaffold(
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
                              color: context.appTextMuted.withValues(
                                alpha: 0.5,
                              ),
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
                    onRefresh: () =>
                        ref.read(userUlistProvider.notifier).fetchAllEntries(),
                    color: context.appAccentTeal,
                    backgroundColor: context.appSurface,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
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
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: context.appSurface,
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
                  tabs: activeLabels.map((label) {
                    final count = ulistState.entries.values
                        .where((entry) => entry.labels.contains(label.id))
                        .where((entry) => entry.vn != null)
                        .length;

                    return Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(label.label ?? ''),
                            const SizedBox(width: 6),
                            Container(
                              height: 18,
                              constraints: const BoxConstraints(minWidth: 18),
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
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
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
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: context.appAccentTeal),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(err.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appAccentTeal,
                  ),
                  onPressed: () => ref.invalidate(ulistLabelsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
