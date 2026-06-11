import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../models/visual_novel.dart';
import '../providers/vn_providers.dart';
import '../widgets/detail_header.dart';
import '../widgets/metadata_row.dart';
import '../widgets/synopsis_section.dart';
import '../widgets/tag_chip.dart';
import '../../../theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

class VnDetailScreen extends ConsumerWidget {
  final String vnId;

  const VnDetailScreen({super.key, required this.vnId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(vnDetailsProvider(vnId));
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final ulistState = ref.watch(vnUlistProvider(vnId));
    final authState = ref.watch(authProvider);

    ref.listen<VnUlistState>(vnUlistProvider(vnId), (previous, next) {
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
      body: detailAsync.when(
        data: (vn) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.appSurface,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    side: BorderSide(
                                      color: Colors.white.withValues(
                                        alpha: 0.08,
                                      ),
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: ulistState.isLoading
                                    ? null
                                    : () => _showLabelsDialog(context, ref, vn),
                                icon: ulistState.isLoading
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
                                label: Text(
                                  ulistState.entry != null &&
                                          ulistState.entry!.labels.isNotEmpty
                                      ? 'Labels (${ulistState.entry!.labels.length})'
                                      : 'My Labels',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.appSurface,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    side: BorderSide(
                                      color: Colors.white.withValues(
                                        alpha: 0.08,
                                      ),
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: ulistState.isLoading
                                    ? null
                                    : () => _showVoteDialog(context, ref, vn),
                                icon: ulistState.isLoading
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
                                label: Text(
                                  ulistState.entry?.vote != null
                                      ? 'Vote: ${ulistState.entry!.vote! / 10}'
                                      : 'My Vote',
                                  style: const TextStyle(
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
                                  ShareParams(
                                    text: 'https://vndb.org/${vn.id}',
                                  ),
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
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
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
                                  ShareParams(
                                    text: 'https://vndb.org/${vn.id}',
                                  ),
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
                      _buildPlatformBadges(context, theme, vn.platforms),
                      const SizedBox(height: 24),

                      // Synopsis Section (Expandable description)
                      if (vn.description != null &&
                          vn.description!.isNotEmpty) ...[
                        SynopsisSection(description: vn.description!),
                        const SizedBox(height: 24),
                      ],

                      // Screenshots (horizontal carousel)
                      if (vn.screenshots.isNotEmpty) ...[
                        Text(
                          'Screenshots',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: vn.screenshots.length,
                            itemBuilder: (context, index) {
                              final screen = vn.screenshots[index];
                              final shouldBlur =
                                  !settings.showExplicitContent &&
                                  screen.sexual != null &&
                                  screen.sexual! > 0.2;

                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        '/gallery',
                                        arguments: {
                                          'screenshots': vn.screenshots,
                                          'initialIndex': index,
                                        },
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: screen.url,
                                          fit: BoxFit.cover,
                                          width: 240,
                                          height: 150,
                                          placeholder: (context, url) =>
                                              Container(
                                                color: context.appSurface,
                                                width: 240,
                                                height: 150,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: context
                                                            .appAccentTeal,
                                                      ),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                color: context.appSurface,
                                                width: 240,
                                                height: 150,
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: context.appTextMuted,
                                                ),
                                              ),
                                        ),
                                        if (shouldBlur)
                                          Positioned.fill(
                                            child: ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 10,
                                                  sigmaY: 10,
                                                ),
                                                child: Container(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.5),
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons
                                                        .visibility_off_rounded,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Tags List
                      if (vn.tags.isNotEmpty) ...[
                        Text(
                          'Tags',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: vn.tags
                              .take(12) // Limit to top 12 tags to keep UI clean
                              .map(
                                (tag) => TagChip(
                                  label: tag.name,
                                  score: tag.rating,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/tag-list',
                                      arguments: {
                                        'tagId': tag.id,
                                        'tagName': tag.name,
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],

                      // External Links Section
                      if (vn.extLinks.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Links',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: vn.extLinks.map((link) {
                            return ActionChip(
                              avatar: Icon(
                                Icons.link_rounded,
                                size: 16,
                                color: context.appAccentTeal,
                              ),
                              label: Text(link.label),
                              onPressed: () async {
                                final uri = Uri.parse(link.url);

                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              backgroundColor: context.appSurface,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: context.appAccentTeal),
        ),
        error: (error, stackTrace) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading visual novel details:\n$error',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appAccentTeal,
                  ),
                  onPressed: () => ref.refresh(vnDetailsProvider(vnId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlatformBadges(
    BuildContext context,
    ThemeData theme,
    List<String> platforms,
  ) {
    if (platforms.isEmpty) {
      return const SizedBox.shrink();
    }

    final platformMeta = <String, (String, IconData)>{
      'win': ('Windows', Icons.laptop_windows_rounded),
      'swi': ('Nintendo Switch', Icons.sports_esports_rounded),
      'ps4': ('PlayStation 4', Icons.gamepad_rounded),
      'ps5': ('PlayStation 5', Icons.gamepad_rounded),
      'ps3': ('PlayStation 3', Icons.gamepad_rounded),
      'psv': ('PlayStation Vita', Icons.tablet_android_rounded),
      'psp': ('PlayStation Portable', Icons.tablet_android_rounded),
      'and': ('Android', Icons.android_rounded),
      'ios': ('iOS', Icons.phone_iphone_rounded),
      'mac': ('macOS', Icons.laptop_mac_rounded),
      'lin': ('Linux', Icons.terminal_rounded),
      'web': ('Web Browser', Icons.language_rounded),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PLATFORMS',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appTextMuted,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: platforms.map((platformCode) {
            final meta =
                platformMeta[platformCode.toLowerCase()] ??
                (platformCode.toUpperCase(), Icons.gamepad_rounded);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.appTextPrimary.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(meta.$2, size: 16, color: context.appAccentTeal),
                  const SizedBox(width: 8),
                  Text(
                    meta.$1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.appTextPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
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
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final labelsAsync = ref.watch(ulistLabelsProvider);
          final ulistState = ref.watch(vnUlistProvider(vn.id));

          return AlertDialog(
            backgroundColor: context.appSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'My Labels',
              style: TextStyle(
                color: context.appTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: labelsAsync.when(
                data: (allLabels) {
                  if (allLabels.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        'No labels found.',
                        style: TextStyle(color: context.appTextMuted),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final selectedLabels = ulistState.entry?.labels ?? const [];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allLabels.length,
                    itemBuilder: (context, index) {
                      final label = allLabels[index];
                      final isSelected = selectedLabels.contains(label.id);

                      return CheckboxListTile(
                        activeColor: context.appAccentTeal,
                        checkColor: Colors.black,
                        title: Text(
                          label.label,
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
                    padding: const EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(
                      color: context.appAccentTeal,
                    ),
                  ),
                ),
                error: (err, stack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Close',
                  style: TextStyle(color: context.appAccentTeal),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showVoteDialog(BuildContext context, WidgetRef ref, VisualNovel vn) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final ulistState = ref.watch(vnUlistProvider(vn.id));
          final currentVote = ulistState.entry?.vote != null
              ? (ulistState.entry!.vote! / 10).round()
              : null;

          return AlertDialog(
            backgroundColor: context.appSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'My Vote',
              style: TextStyle(
                color: context.appTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (currentVote != null) ...[
                    ListTile(
                      leading: Icon(Icons.star, color: context.appAccentTeal),
                      title: Text(
                        'Current Vote: $currentVote (${_ratingDescriptions[currentVote]})',
                        style: TextStyle(
                          color: context.appTextPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white12),
                  ],
                  ..._ratingDescriptions.entries.map((entry) {
                    final score = entry.key;
                    final label = entry.value;
                    final isSelected = currentVote == score;

                    return ListTile(
                      leading: Icon(
                        isSelected
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: isSelected
                            ? context.appAccentTeal
                            : context.appTextMuted,
                      ),
                      title: Text(
                        '$score - $label',
                        style: TextStyle(
                          color: isSelected
                              ? context.appTextPrimary
                              : context.appTextMuted,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle_outline,
                              color: context.appAccentTeal,
                            )
                          : null,
                      onTap: ulistState.isLoading
                          ? null
                          : () {
                              ref
                                  .read(userUlistProvider.notifier)
                                  .updateVote(vn.id, score * 10);
                              Navigator.of(context).pop();
                            },
                    );
                  }),
                  if (currentVote != null) ...[
                    const Divider(color: Colors.white12),
                    ListTile(
                      leading: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                      ),
                      title: const Text(
                        'Clear Vote',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: ulistState.isLoading
                          ? null
                          : () {
                              ref
                                  .read(userUlistProvider.notifier)
                                  .updateVote(vn.id, null);
                              Navigator.of(context).pop();
                            },
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: context.appAccentTeal),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
