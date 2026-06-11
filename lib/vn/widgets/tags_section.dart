import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vn_tag.dart';
import 'tag_chip.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class TagsSection extends ConsumerStatefulWidget {
  final List<VnTag> tags;

  const TagsSection({super.key, required this.tags});

  @override
  ConsumerState<TagsSection> createState() => _TagsSectionState();
}

class _TagsSectionState extends ConsumerState<TagsSection> {
  bool _areTagsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    var displayTagsList = widget.tags;

    if (!settings.showExplicitContent) {
      displayTagsList = displayTagsList
          .where((tag) => tag.category != 'ero')
          .toList();
    }

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
              (_areTagsExpanded ? displayTagsList : displayTagsList.take(12))
                  .map(
                    (tag) => TagChip(
                      label: tag.name,
                      score: tag.rating,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/tag-list',
                          arguments: {'tagId': tag.id, 'tagName': tag.name},
                        );
                      },
                    ),
                  )
                  .toList(),
        ),
        if (displayTagsList.length > 12) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _areTagsExpanded = !_areTagsExpanded;
                });
              },
              icon: Icon(
                _areTagsExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: context.appAccentTeal,
                size: 20,
              ),
              label: Text(
                _areTagsExpanded ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: context.appAccentTeal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
