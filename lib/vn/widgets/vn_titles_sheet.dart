import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../models/visual_novel.dart';
import 'vn_title_sheet_item.dart';

class VnTitlesSheet extends StatelessWidget {
  const VnTitlesSheet({
    super.key,
    required this.titles,
  });

  final List<VnTitle> titles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleCount = titles.length;
    final titleLabel = titleCount == 1 ? '1 title' : '$titleCount titles';

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 12.0, 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titles',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          titleLabel,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.appTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    icon: const Icon(Icons.close_rounded),
                    color: context.appTextSecondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 28.0),
                itemCount: titles.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  return VnTitleSheetItem(title: titles[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
