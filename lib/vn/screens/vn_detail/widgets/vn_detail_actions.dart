import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../auth/providers/auth_provider.dart';
import '../../../../theme/app_theme.dart';
import '../../../models/visual_novel.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/connect_vndb_button.dart';
import 'action_button.dart';
import 'vn_detail_labels_sheet.dart';
import 'vn_detail_user_action_button.dart';
import 'vn_detail_vote_sheet.dart';

class VnDetailActions extends ConsumerStatefulWidget {
  const VnDetailActions({
    super.key,
    required this.vn,
  });

  final VisualNovel vn;

  @override
  ConsumerState<VnDetailActions> createState() {
    return VnDetailActionsState();
  }
}

class VnDetailActionsState extends ConsumerState<VnDetailActions> {
  @override
  void initState() {
    super.initState();
    _scheduleUserListLoad();
  }

  @override
  void didUpdateWidget(covariant VnDetailActions oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.vn.id != widget.vn.id) {
      _scheduleUserListLoad();
    }
  }

  void _scheduleUserListLoad() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final auth = ref.read(authProvider);

      if (auth.isAuthenticated) {
        ref.read(userUlistProvider.notifier).ensureEntriesLoaded();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vn = widget.vn;
    final ulistState = ref.watch(vnUlistProvider(vn.id));
    final isAuthenticated = ref.watch(
      authProvider.select((state) => state.isAuthenticated),
    );
    final activeLabelsCount =
        ulistState.entry?.labels.where((id) => id != 0 && id != 7).length ?? 0;

    ref.listen<VnUlistState>(vnUlistProvider(vn.id), (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('VNDB Error: ${next.errorMessage}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    });

    if (!isAuthenticated) {
      return Row(
        children: [
          const Expanded(
            child: ConnectVndbButton(),
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: Icons.share_outlined,
            onTap: () => _shareVn(vn),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: VnDetailUserActionButton(
            icon: Icons.label_outline_rounded,
            label: ulistState.entry != null && activeLabelsCount > 0
                ? 'Labels'
                : 'My Labels',
            count: ulistState.entry != null && activeLabelsCount > 0
                ? activeLabelsCount
                : null,
            isLoading: ulistState.isLoading,
            onPressed: () => showVnLabelsSheet(context, vn),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: VnDetailUserActionButton(
            icon: Icons.star_outline_rounded,
            label: ulistState.entry?.vote != null ? 'Vote' : 'My Vote',
            count: ulistState.entry?.vote != null
                ? (ulistState.entry!.vote! / 10).toInt()
                : null,
            isLoading: ulistState.isLoading,
            onPressed: () => showVnVoteSheet(context, vn),
          ),
        ),
        const SizedBox(width: 12),
        ActionButton(
          icon: Icons.share_outlined,
          onTap: () => _shareVn(vn),
        ),
      ],
    );
  }

  void _shareVn(VisualNovel vn) {
    SharePlus.instance.share(
      ShareParams(
        text: 'https://vndb.org/${vn.id}',
      ),
    );
  }
}
