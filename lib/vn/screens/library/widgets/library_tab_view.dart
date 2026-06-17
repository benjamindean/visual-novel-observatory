import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/vn_card.dart';
import 'library_empty_label_view.dart';

class LibraryTabView extends ConsumerWidget {
  const LibraryTabView({
    super.key,
    required this.label,
  });

  final VndbLabel label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(userUlistIsLoadingProvider);
    final vns = ref.watch(libraryVnsByLabelProvider(label.id));

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: context.appAccentTeal,
        ),
      );
    }

    return RefreshIndicator(
      key: ValueKey('refresh_${label.id}'),
      onRefresh: () => ref.read(userUlistProvider.notifier).fetchAllEntries(),
      color: context.appAccentTeal,
      backgroundColor: context.appSurface,
      child: vns.isEmpty
          ? LibraryEmptyLabelView(label: label)
          : GridView.builder(
              key: PageStorageKey('library_grid_${label.id}'),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  }
}
