import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_tag.dart';
import 'tag_chip.dart';
import 'chip_overflow_wrap.dart';
import '../../settings/providers/settings_provider.dart';

class TagsSection extends ConsumerStatefulWidget {
  final List<VnTag> tags;
  final int initialLimit;

  const TagsSection({super.key, required this.tags, this.initialLimit = 6});

  @override
  ConsumerState<TagsSection> createState() => _TagsSectionState();
}

class _TagsSectionState extends ConsumerState<TagsSection> {
  List<VnTag> _getDisplayTags({
    required int spoilerLevel,
    required bool blurSexualContent,
  }) {
    final filtered = widget.tags.where((tag) {
      final isExplicit = tag.category == 'ero';
      final isAllowedSpoiler = tag.spoiler <= spoilerLevel;

      return isAllowedSpoiler && (!blurSexualContent || !isExplicit);
    }).toList();

    filtered.sort((a, b) => (b.rating ?? 0.0).compareTo(a.rating ?? 0.0));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(
      settingsProvider.select(
        (settings) => (
          spoilerLevel: settings.spoilerLevel,
          blurSexualContent: settings.blurSexualContent,
        ),
      ),
    );
    final displayTagsList = _getDisplayTags(
      spoilerLevel: settings.spoilerLevel,
      blurSexualContent: settings.blurSexualContent,
    );

    if (displayTagsList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ChipOverflowWrap(
          initialLimit: widget.initialLimit,
          children: displayTagsList
              .map(
                (tag) => TagChip(
                  label: tag.name,
                  score: tag.rating,
                  onTap: () {
                    context.push(
                      '/tag-list',
                      extra: {'tagId': tag.id, 'tagName': tag.name},
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
