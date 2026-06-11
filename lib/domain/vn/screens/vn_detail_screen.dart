import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/vn_providers.dart';
import '../widgets/detail_header.dart';
import '../widgets/metadata_row.dart';
import '../widgets/synopsis_section.dart';
import '../widgets/tag_chip.dart';
import '../../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class VnDetailScreen extends ConsumerWidget {
  final String vnId;

  const VnDetailScreen({super.key, required this.vnId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(vnDetailsProvider(vnId));
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

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

                      // Action buttons (Teal Play/Read button + Share/Heart)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.accentTeal,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                size: 24,
                              ),
                              label: const Text(
                                'Read Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _ActionButton(
                            icon: Icons.bookmark_border_rounded,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          _ActionButton(
                            icon: Icons.share_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Metadata Row (Release, Playtime, Platforms)
                      MetadataRow(vn: vn),
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
                                                color: AppTheme.surface,
                                                width: 240,
                                                height: 150,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color:
                                                            AppTheme.accentTeal,
                                                      ),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                color: AppTheme.surface,
                                                width: 240,
                                                height: 150,
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  color: AppTheme.textMuted,
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
                              avatar: const Icon(
                                Icons.link_rounded,
                                size: 16,
                                color: AppTheme.accentTeal,
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
                              backgroundColor: AppTheme.surface,
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
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppTheme.accentTeal),
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
                    backgroundColor: AppTheme.accentTeal,
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
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
