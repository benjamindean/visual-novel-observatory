import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/vn_providers.dart';
import '../widgets/vn_card.dart';
import '../../theme/app_theme.dart';

class VnByTagScreen extends ConsumerStatefulWidget {
  final String tagId;
  final String tagName;

  const VnByTagScreen({super.key, required this.tagId, required this.tagName});

  @override
  ConsumerState<VnByTagScreen> createState() => _VnByTagScreenState();
}

class _VnByTagScreenState extends ConsumerState<VnByTagScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(vnListByTagProvider(widget.tagId).notifier).fetchVns();
    }
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(vnListByTagProvider(widget.tagId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tagName),
        backgroundColor: context.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: context.appTextPrimary,
            size: 18,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref
              .read(vnListByTagProvider(widget.tagId).notifier)
              .resetAndFetch(),
          color: context.appAccentTeal,
          backgroundColor: context.appSurface,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (listState.isLoading)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: context.appAccentTeal,
                    ),
                  ),
                )
              else if (listState.errorMessage != null && listState.vns.isEmpty)
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: context.colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${listState.errorMessage}',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appAccentTeal,
                            ),
                            onPressed: () => ref
                                .read(
                                  vnListByTagProvider(widget.tagId).notifier,
                                )
                                .resetAndFetch(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (listState.vns.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No visual novels found for this tag',
                      style: TextStyle(color: context.appTextMuted),
                    ),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2 / 3,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final vn = listState.vns[index];

                      return VnCard(
                        vn: vn,
                        onTap: () {
                          context.push('/detail', extra: vn);
                        },
                      );
                    }, childCount: listState.vns.length),
                  ),
                ),
                if (listState.hasMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: context.appAccentTeal,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
