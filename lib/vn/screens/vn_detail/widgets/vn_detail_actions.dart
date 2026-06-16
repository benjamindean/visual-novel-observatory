import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import '../../../models/visual_novel.dart';
import '../../../providers/vn_providers.dart';
import '../../../widgets/connect_vndb_button.dart';
import '../../../../theme/app_theme.dart';
import '../../../../auth/providers/auth_provider.dart';
import 'action_button.dart';

class VnDetailActions extends ConsumerWidget {
  final VisualNovel vn;

  const VnDetailActions({super.key, required this.vn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ulistState = ref.watch(vnUlistProvider(vn.id));
    final authState = ref.watch(authProvider);
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

    if (authState.isAuthenticated) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appSurface,
                foregroundColor: context.appTextPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              onPressed: ulistState.isLoading
                  ? null
                  : () => _showLabelsDialog(context, ref, vn),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ulistState.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.appAccentTeal,
                          ),
                        )
                      : Icon(
                          Icons.label_outline_rounded,
                          size: 20,
                          color: context.appAccentTeal,
                        ),
                  const SizedBox(width: 8),
                  Text(
                    ulistState.entry != null && activeLabelsCount > 0
                        ? 'Labels'
                        : 'My Labels',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (ulistState.entry != null && activeLabelsCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.appAccentTeal,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$activeLabelsCount',
                        style: TextStyle(
                          color: context.colorScheme.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appSurface,
                foregroundColor: context.appTextPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              onPressed: ulistState.isLoading
                  ? null
                  : () => _showVoteDialog(context, ref, vn),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ulistState.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.appAccentTeal,
                          ),
                        )
                      : Icon(
                          Icons.star_border_rounded,
                          size: 20,
                          color: context.appAccentTeal,
                        ),
                  const SizedBox(width: 8),
                  Text(
                    ulistState.entry?.vote != null ? 'Vote' : 'My Vote',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (ulistState.entry?.vote != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.appAccentTeal,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${(ulistState.entry!.vote! / 10).toInt()}',
                        style: TextStyle(
                          color: context.colorScheme.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          ActionButton(
            icon: Icons.share_outlined,
            onTap: () {
              SharePlus.instance.share(
                ShareParams(
                  text: 'https://vndb.org/${vn.id}',
                ),
              );
            },
          ),
        ],
      );
    }

    return Row(
      children: [
        const Expanded(
          child: ConnectVndbButton(),
        ),
        const SizedBox(width: 12),
        ActionButton(
          icon: Icons.share_outlined,
          onTap: () {
            SharePlus.instance.share(
              ShareParams(
                text: 'https://vndb.org/${vn.id}',
              ),
            );
          },
        ),
      ],
    );
  }
}

const Map<int, String> _ratingDescriptions = {
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

void _showLabelsDialog(BuildContext context, WidgetRef ref, VisualNovel vn) {
  List<int>? tempLabels;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Consumer(
            builder: (context, ref, child) {
              final labelsAsync = ref.watch(ulistLabelsProvider);
              final ulistState = ref.watch(vnUlistProvider(vn.id));
              final theme = Theme.of(context);

              if (tempLabels == null) {
                if (ulistState.entry != null) {
                  tempLabels = List<int>.from(ulistState.entry!.labels);
                } else if (!ulistState.isLoading) {
                  tempLabels = <int>[];
                }
              }

              final currentSelected = tempLabels ?? const <int>[];

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
                      // Drag handle
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

                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'My Labels',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Content list
                      Flexible(
                        child: labelsAsync.when(
                          data: (allLabels) {
                            final filteredLabels = allLabels
                                .where(
                                  (l) => l.label != null && l.label!.isNotEmpty,
                                )
                                .where((l) => l.id != 0 && l.id != 7)
                                .where(
                                  (l) =>
                                      l.label!.toLowerCase() != 'no label' &&
                                      l.label!.toLowerCase() != 'voted',
                                )
                                .toList();

                            if (filteredLabels.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  'No labels found.',
                                  style: TextStyle(color: context.appTextMuted),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: filteredLabels.length,
                              itemBuilder: (context, index) {
                                final label = filteredLabels[index];
                                final isSelected = currentSelected.contains(
                                  label.id,
                                );

                                return CheckboxListTile(
                                  activeColor: context.appAccentTeal,
                                  checkColor: context.colorScheme.onPrimary,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  title: Text(
                                    label.label ?? '',
                                    style: TextStyle(
                                      color: context.appTextPrimary,
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  value: isSelected,
                                  onChanged: (val) {
                                    HapticFeedback.lightImpact();

                                    setState(() {
                                      if (val == true) {
                                        tempLabels!.add(label.id);
                                      } else {
                                        tempLabels!.remove(label.id);
                                      }
                                    });
                                  },
                                );
                              },
                            );
                          },
                          loading: () => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (err, stack) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 32.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              'Failed to load labels: $err',
                              style: TextStyle(
                                color: context.colorScheme.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      // Save Button (thumb-stretch aware)
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
                          onPressed: () {
                            if (tempLabels != null) {
                              final originalLabels =
                                  ulistState.entry?.labels ?? const <int>[];
                              final bool hasChanged =
                                  originalLabels.length != tempLabels!.length ||
                                  !originalLabels.every(tempLabels!.contains);

                              if (hasChanged) {
                                ref
                                    .read(userUlistProvider.notifier)
                                    .updateLabels(
                                      vn.id,
                                      tempLabels!,
                                      vn: vn,
                                    );
                              }
                            }

                            context.pop();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

void _showVoteDialog(BuildContext context, WidgetRef ref, VisualNovel vn) {
  int? tempVote;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final ulistState = ref.watch(vnUlistProvider(vn.id));
          final originalVote = ulistState.entry?.vote != null
              ? (ulistState.entry!.vote! / 10).round()
              : null;

          return StatefulBuilder(
            builder: (context, setState) {
              tempVote ??= originalVote;

              final selectedVote = tempVote ?? 8;
              final description = _ratingDescriptions[selectedVote] ?? '';
              final theme = Theme.of(context);

              return Material(
                color: context.appBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20.0,
                    16.0,
                    20.0,
                    MediaQuery.of(context).padding.bottom + 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Drag handle
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

                      // Title
                      Row(
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
                      const SizedBox(height: 24.0),

                      // Prominent Score Display
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

                      // Slider
                      Slider(
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
                      const SizedBox(height: 24.0),

                      // Save button
                      ElevatedButton(
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
                                    .updateVote(vn, selectedVote * 10);
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

                      // Clear button
                      if (originalVote != null) ...[
                        const SizedBox(height: 12.0),
                        OutlinedButton(
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
                                      .updateVote(vn, null);
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
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
