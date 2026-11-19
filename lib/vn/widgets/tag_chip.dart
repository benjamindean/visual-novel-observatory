import 'package:material_ui/material_ui.dart';

import 'app_chip.dart';
import '../../theme/app_theme.dart';

class TagChip extends StatelessWidget {
  final String label;
  final double? score;
  final VoidCallback? onTap;

  const TagChip({super.key, required this.label, this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: label,
      onTap: onTap,
      trailing: score != null
          ? Text(
              '• ${score!.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.appAccentTeal,
              ),
            )
          : null,
    );
  }
}
