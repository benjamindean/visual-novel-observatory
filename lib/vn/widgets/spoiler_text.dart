import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';

class SpoilerText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const SpoilerText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<SpoilerText> createState() => _SpoilerTextState();
}

class _SpoilerTextState extends State<SpoilerText> {
  final Map<int, bool> _revealedSpoilers = {};

  static final RegExp _urlRegExp = RegExp(r'\[url=[^\]]+\]');

  String _cleanBBCode(String text) {
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
    final textStyle = widget.style ?? theme.textTheme.bodyMedium;
    final regExp = RegExp(r'\[spoiler\](.*?)\[/spoiler\]', dotAll: true);
    final matches = regExp.allMatches(widget.text);

    if (matches.isEmpty) {
      return Text(
        _cleanBBCode(widget.text),
        style: textStyle,
      );
    }

    final List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (int i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      // Add text before the spoiler
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: _cleanBBCode(widget.text.substring(lastIndex, match.start)),
          ),
        );
      }

      final spoilerContent = _cleanBBCode(match.group(1) ?? '');
      final isRevealed = _revealedSpoilers[i] ?? false;

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _revealedSpoilers[i] = !isRevealed;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isRevealed
                    ? context.appAccentTeal.withValues(alpha: 0.15)
                    : context.appTextMuted.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isRevealed ? spoilerContent : 'Spoiler (Tap to reveal)',
                style: textStyle?.copyWith(
                  color: isRevealed
                      ? context.appAccentTeal
                      : context.appTextMuted,
                  fontWeight: isRevealed ? FontWeight.normal : FontWeight.bold,
                  fontSize: isRevealed ? null : 12,
                ),
              ),
            ),
          ),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < widget.text.length) {
      spans.add(
        TextSpan(
          text: _cleanBBCode(widget.text.substring(lastIndex)),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: textStyle,
      ),
    );
  }
}
