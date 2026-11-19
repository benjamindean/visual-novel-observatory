import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';

class LibraryLabelTab extends ConsumerWidget {
  const LibraryLabelTab({
    super.key,
    required this.label,
    required this.index,
  });

  final VndbLabel label;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(libraryVnCountByLabelProvider(label.id));

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
            _LibraryLabelCountBadge(
              count: count,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryLabelCountBadge extends StatefulWidget {
  const _LibraryLabelCountBadge({
    required this.count,
    required this.index,
  });

  final int count;
  final int index;

  @override
  State<_LibraryLabelCountBadge> createState() {
    return _LibraryLabelCountBadgeState();
  }
}

class _LibraryLabelCountBadgeState extends State<_LibraryLabelCountBadge> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final nextController = DefaultTabController.of(context);

    if (_controller == nextController) {
      return;
    }

    _controller?.removeListener(_handleTabChange);
    _controller = nextController;
    _controller?.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _controller?.index == widget.index;
    final backgroundColor = isActive
        ? context.appAccentTeal
        : context.colorScheme.surfaceContainerHighest;
    final foregroundColor = isActive
        ? context.colorScheme.onPrimary
        : context.appTextMuted;

    return Container(
      height: 18,
      constraints: const BoxConstraints(
        minWidth: 18,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: Text(
        '${widget.count}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: foregroundColor,
        ),
      ),
    );
  }
}
