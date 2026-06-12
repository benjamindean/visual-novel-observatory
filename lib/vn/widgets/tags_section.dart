import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/vn_tag.dart';
import 'tag_chip.dart';
import 'expand_toggle_button.dart';
import '../../settings/providers/settings_provider.dart';

class TagsSection extends ConsumerStatefulWidget {
  final List<VnTag> tags;
  final int initialLimit;

  const TagsSection({super.key, required this.tags, this.initialLimit = 12});

  @override
  ConsumerState<TagsSection> createState() => _TagsSectionState();
}

class _TagsSectionState extends ConsumerState<TagsSection> {
  bool _areTagsExpanded = false;

  List<VnTag> _getDisplayTags(bool showExplicitContent) {
    final filtered = showExplicitContent
        ? List<VnTag>.from(widget.tags)
        : widget.tags.where((tag) => tag.category != 'ero').toList();

    filtered.sort((a, b) => (b.rating ?? 0.0).compareTo(a.rating ?? 0.0));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final displayTagsList = _getDisplayTags(settings.showExplicitContent);

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
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              (_areTagsExpanded
                      ? displayTagsList
                      : displayTagsList.take(widget.initialLimit))
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
        if (displayTagsList.length > widget.initialLimit) ...[
          const SizedBox(height: 12),
          ExpandToggleButton(
            isExpanded: _areTagsExpanded,
            onPressed: () {
              setState(() {
                _areTagsExpanded = !_areTagsExpanded;
              });
            },
          ),
        ],
      ],
    );
  }
}
