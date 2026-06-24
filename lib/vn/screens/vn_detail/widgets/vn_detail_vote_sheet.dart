import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/visual_novel.dart';
import '../../../providers/vn_providers.dart';

const Map<int, String> ratingDescriptions = {
  10: 'Masterpiece',
  9: 'Excellent',
  8: 'Very good',
  7: 'Good',
  6: 'Decent',
  5: 'Average',
  4: 'Bad',
  3: 'Very bad',
  2: 'Horrible',
  1: 'Worst ever',
};

Future<void> showVnVoteSheet(
  BuildContext context,
  VisualNovel vn,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return VnDetailVoteSheet(vn: vn);
    },
  );
}

class VnDetailVoteSheet extends ConsumerStatefulWidget {
  const VnDetailVoteSheet({
    super.key,
    required this.vn,
  });

  final VisualNovel vn;

  @override
  ConsumerState<VnDetailVoteSheet> createState() {
    return VnDetailVoteSheetState();
  }
}

class VnDetailVoteSheetState extends ConsumerState<VnDetailVoteSheet> {
  int? tempVote;

  @override
  Widget build(BuildContext context) {
    final ulistState = ref.watch(vnUlistProvider(widget.vn.id));
    final originalVote = ulistState.entry?.vote != null
        ? (ulistState.entry!.vote! / 10).round()
        : null;

    tempVote ??= originalVote;

    final selectedVote = tempVote ?? 8;
    final description = ratingDescriptions[selectedVote] ?? '';
    final theme = Theme.of(context);

    return Material(
      color: context.appBackground,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: context.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rate Visual Novel',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (originalVote != null)
                    Text(
                      'Current: $originalVote',
                      style: TextStyle(
                        color: context.appAccentTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Column(
                children: [
                  Text(
                    '$selectedVote / 10',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: context.appAccentTeal,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      color: context.appTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Slider(
                value: selectedVote.toDouble(),
                min: 1.0,
                max: 10.0,
                divisions: 9,
                activeColor: context.appAccentTeal,
                inactiveColor: context.appSurface,
                onChanged: (val) {
                  HapticFeedback.selectionClick();

                  setState(() {
                    tempVote = val.round();
                  });
                },
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appAccentTeal,
                  foregroundColor: context.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  elevation: 0,
                ),
                onPressed: ulistState.isLoading
                    ? null
                    : () {
                        HapticFeedback.lightImpact();

                        ref
                            .read(userUlistProvider.notifier)
                            .updateVote(widget.vn, selectedVote * 10);
                        context.pop();
                      },
                child: ulistState.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.colorScheme.onPrimary,
                        ),
                      )
                    : const Text(
                        'Save Vote',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
              ),
            ),
            if (originalVote != null) ...[
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                    side: BorderSide(color: context.colorScheme.error),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: ulistState.isLoading
                      ? null
                      : () {
                          HapticFeedback.lightImpact();

                          ref
                              .read(userUlistProvider.notifier)
                              .updateVote(widget.vn, null);
                          context.pop();
                        },
                  child: const Text(
                    'Clear Vote',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
