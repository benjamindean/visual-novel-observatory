import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vn_providers.dart';
import '../../widgets/vn_card.dart';
import '../../../theme/app_theme.dart';
import '../../../core/widgets/sliver_loading_indicator.dart';

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
        bottom: false,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
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
                          'No Visual Novels',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.appTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No visual novels found for this tag.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  32,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              if (listState.hasMore) const SliverLoadingIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
