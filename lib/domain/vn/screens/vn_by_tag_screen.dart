import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import '../widgets/vn_card.dart';
import '../../../theme/app_theme.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref
              .read(vnListByTagProvider(widget.tagId).notifier)
              .resetAndFetch(),
          color: AppTheme.accentTeal,
          backgroundColor: AppTheme.surface,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (listState.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.accentTeal,
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
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.redAccent,
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
                              backgroundColor: AppTheme.accentTeal,
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
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No visual novels found for this tag',
                      style: TextStyle(color: AppTheme.textMuted),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= listState.vns.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppTheme.accentTeal,
                                ),
                              ),
                            ),
                          );
                        }

                        final vn = listState.vns[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: VnCard(
                            vn: vn,
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed('/detail', arguments: vn.id);
                            },
                          ),
                        );
                      },
                      childCount:
                          listState.vns.length + (listState.hasMore ? 1 : 0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
