import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/vn_providers.dart';
import 'vn_releases_content.dart';
import 'vn_releases_loading.dart';

class VnReleasesSection extends ConsumerWidget {
  const VnReleasesSection({
    super.key,
    required this.vnId,
  });

  final String vnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releasesAsync = ref.watch(vnReleasesProvider(vnId));

    return releasesAsync.when(
      data: (releases) => VnReleasesContent(
        vnId: vnId,
        releases: releases,
      ),
      loading: () => const VnReleasesLoading(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
