import 'package:material_ui/material_ui.dart';

import '../../models/vn_tag.dart';
import '../tag_filter/tag_filter_screen.dart';
import '../../../theme/app_theme.dart';

class FilterTagsTile extends StatelessWidget {
  final List<VnTag> selectedTags;
  final ValueChanged<List<VnTag>> onTagsChanged;

  const FilterTagsTile({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push<List<VnTag>>(
                MaterialPageRoute(
                  builder: (context) =>
                      TagFilterScreen(initialTags: selectedTags),
                ),
              )
              .then((result) {
                if (result != null) {
                  onTagsChanged(result);
                }
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedTags.isEmpty)
                      Text(
                        'Select Tags...',
                        style: TextStyle(
                          color: context.appTextSecondary,
                          fontSize: 14,
                        ),
                      )
                    else
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedTags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              tag.name,
                              style: TextStyle(
                                color: context
                                    .theme
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: context.appTextMuted),
            ],
          ),
        ),
      ),
    );
  }
}
