import 'package:material_ui/material_ui.dart';

import 'expand_toggle_button.dart';
import '../../theme/app_theme.dart';

class SynopsisSection extends StatefulWidget {
  final String description;

  const SynopsisSection({super.key, required this.description});

  @override
  State<SynopsisSection> createState() => _SynopsisSectionState();
}

class _SynopsisSectionState extends State<SynopsisSection> {
  bool _isExpanded = false;

  static final RegExp _urlRegExp = RegExp(r'\[url=[^\]]+\]');

  // Simple clean-up helper for VNDB bbcode formatting in description
  String _cleanDescription(String text) {
    return text
        .replaceAll(_urlRegExp, '')
        .replaceAll('[/url]', '')
        .replaceAll('[b]', '')
        .replaceAll('[/b]', '')
        .replaceAll('[i]', '')
        .replaceAll('[/i]', '')
        .replaceAll('[u]', '')
        .replaceAll('[/u]', '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cleanedText = _cleanDescription(widget.description);

    // Check if the text is long enough to need expansion
    final isLong = cleanedText.length > 220;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Story Line',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cleanedText,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appTextSecondary,
                  height: 1.5,
                ),
              ),
              if (isLong)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ExpandToggleButton(
                    isExpanded: false,
                    onPressed: () => setState(() => _isExpanded = true),
                  ),
                ),
            ],
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cleanedText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appTextSecondary,
                  height: 1.5,
                ),
              ),
              if (isLong)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ExpandToggleButton(
                    isExpanded: true,
                    onPressed: () => setState(() => _isExpanded = false),
                  ),
                ),
            ],
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
