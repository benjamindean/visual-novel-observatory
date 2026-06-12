import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import '../models/visual_novel.dart';
import '../providers/vn_providers.dart';
import '../widgets/detail_header.dart';
import '../widgets/metadata_row.dart';
import '../widgets/platforms_section.dart';
import '../widgets/synopsis_section.dart';
import '../widgets/tags_section.dart';
import '../widgets/links_section.dart';
import '../widgets/screenshots_section.dart';
import '../widgets/vndb_source_note.dart';
import '../../theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';

class VnDetailScreen extends ConsumerWidget {
  final VisualNovel vn;

  const VnDetailScreen({super.key, required this.vn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ulistState = ref.watch(vnUlistProvider(vn.id));
    final authState = ref.watch(authProvider);

    ref.listen<VnUlistState>(vnUlistProvider(vn.id), (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('VNDB Error: ${next.errorMessage}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Hero Poster + Title overlay)
            DetailHeader(vn: vn),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Action buttons (My Labels, My Vote, Share)
                  if (authState.isAuthenticated)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appSurface,
                              foregroundColor: context.appTextPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(
                                  color: context.appTextPrimary.withValues(
                                    alpha: 0.08,
                                  ),
                                ),
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
                                  ulistState.entry != null &&
                                          ulistState.entry!.labels.isNotEmpty
                                      ? 'Labels'
                                      : 'My Labels',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                if (ulistState.entry != null &&
                                    ulistState.entry!.labels.isNotEmpty) ...[
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
                                      '${ulistState.entry!.labels.length}',
                                      style: const TextStyle(
                                        color: Colors.black,
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
                                side: BorderSide(
                                  color: context.appTextPrimary.withValues(
                                    alpha: 0.08,
                                  ),
                                ),
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
                                  ulistState.entry?.vote != null
                                      ? 'Vote'
                                      : 'My Vote',
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
                                      style: const TextStyle(
                                        color: Colors.black,
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
                        _ActionButton(
                          icon: Icons.share_outlined,
                          onTap: () {
                            SharePlus.instance.share(
                              ShareParams(text: 'https://vndb.org/${vn.id}'),
                            );
                          },
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appAccentTeal,
                              foregroundColor: context.colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              context.push('/login');
                            },
                            icon: const Icon(Icons.login_rounded, size: 20),
                            label: const Text(
                              'Connect VNDB',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _ActionButton(
                          icon: Icons.share_outlined,
                          onTap: () {
                            SharePlus.instance.share(
                              ShareParams(text: 'https://vndb.org/${vn.id}'),
                            );
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),

                  // Metadata Row (Release, Playtime)
                  MetadataRow(vn: vn),
                  const SizedBox(height: 20),

                  // Platforms Section
                  PlatformsSection(platforms: vn.platforms),
                  const SizedBox(height: 24),

                  // Synopsis Section (Expandable description)
                  if (vn.description != null && vn.description!.isNotEmpty) ...[
                    SynopsisSection(description: vn.description!),
                    const SizedBox(height: 24),
                  ],

                  // Screenshots (horizontal carousel)
                  ScreenshotsSection(screenshots: vn.screenshots),
                  if (vn.screenshots.isNotEmpty) const SizedBox(height: 24),

                  // Tags List
                  TagsSection(tags: vn.tags, initialLimit: 7),
                  if (vn.tags.isNotEmpty) const SizedBox(height: 24),

                  // External Links Section
                  LinksSection(extLinks: vn.extLinks),

                  const SizedBox(height: 40),
                  const Center(child: VndbSourceNote()),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.appTextPrimary.withValues(alpha: 0.08),
          ),
        ),
        child: Icon(icon, color: context.appTextPrimary, size: 22),
      ),
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
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final labelsAsync = ref.watch(ulistLabelsProvider);
          final ulistState = ref.watch(vnUlistProvider(vn.id));
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
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: context.appTextPrimary.withValues(alpha: 0.15),
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
                              (label) =>
                                  label.label != null &&
                                  label.label!.toLowerCase() != 'no label' &&
                                  label.label!.toLowerCase() != 'voted',
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

                        final selectedLabels =
                            ulistState.entry?.labels ?? const [];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredLabels.length,
                          itemBuilder: (context, index) {
                            final label = filteredLabels[index];
                            final isSelected = selectedLabels.contains(
                              label.id,
                            );

                            return CheckboxListTile(
                              activeColor: context.appAccentTeal,
                              checkColor: Colors.black,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              title: Text(
                                label.label ?? '',
                                style: TextStyle(color: context.appTextPrimary),
                              ),
                              value: isSelected,
                              onChanged: ulistState.isLoading
                                  ? null
                                  : (checked) {
                                      final newLabels = List<int>.from(
                                        selectedLabels,
                                      );

                                      if (checked == true) {
                                        newLabels.add(label.id);
                                      } else {
                                        newLabels.remove(label.id);
                                      }

                                      ref
                                          .read(userUlistProvider.notifier)
                                          .updateLabels(vn.id, newLabels);
                                    },
                            );
                          },
                        );
                      },
                      loading: () => Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: CircularProgressIndicator(
                            color: context.appAccentTeal,
                          ),
                        ),
                      ),
                      error: (err, stack) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 20.0,
                        ),
                        child: Text(
                          'Error: $err',
                          style: TextStyle(color: context.colorScheme.error),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // Done Button (thumb-stretch aware)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appAccentTeal,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => context.pop(),
                      child: const Text(
                        'Done',
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
                            color: context.appTextPrimary.withValues(
                              alpha: 0.15,
                            ),
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
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          elevation: 0,
                        ),
                        onPressed: ulistState.isLoading
                            ? null
                            : () {
                                ref
                                    .read(userUlistProvider.notifier)
                                    .updateVote(vn.id, selectedVote * 10);
                                context.pop();
                              },
                        child: ulistState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
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
                            side: BorderSide(
                              color: context.colorScheme.error.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          onPressed: ulistState.isLoading
                              ? null
                              : () {
                                  ref
                                      .read(userUlistProvider.notifier)
                                      .updateVote(vn.id, null);
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
