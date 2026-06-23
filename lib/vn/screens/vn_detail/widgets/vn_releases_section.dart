import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/vn_providers.dart';
import 'vn_releases_content.dart';
import 'vn_releases_loading.dart';

class VnReleasesSection extends ConsumerStatefulWidget {
  const VnReleasesSection({
    super.key,
    required this.vnId,
  });

  final String vnId;

  @override
  ConsumerState<VnReleasesSection> createState() {
    return VnReleasesSectionState();
  }
}

class VnReleasesSectionState extends ConsumerState<VnReleasesSection> {
  @override
  void initState() {
    super.initState();
    _scheduleReleasesLoad();
  }

  @override
  void didUpdateWidget(covariant VnReleasesSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.vnId != widget.vnId) {
      _scheduleReleasesLoad();
    }
  }

  void _scheduleReleasesLoad() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ref.read(vnReleasesProvider(widget.vnId).notifier).loadReleases();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vnId = widget.vnId;
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
