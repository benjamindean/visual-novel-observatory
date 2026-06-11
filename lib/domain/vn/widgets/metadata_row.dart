import 'package:flutter/material.dart';
import '../models/visual_novel.dart';
import '../../../theme/app_theme.dart';

class MetadataRow extends StatelessWidget {
  final VisualNovel vn;

  const MetadataRow({super.key, required this.vn});

  @override
  Widget build(BuildContext context) {
    // Format playtime string
    String playtime = 'Length Unknown';

    if (vn.lengthMinutes != null) {
      final hours = vn.lengthMinutes! ~/ 60;

      playtime = '${hours}h (${vn.playLengthLabel})';
    } else if (vn.length != null) {
      playtime = vn.playLengthLabel;
    }

    final platformStr = vn.platforms.isNotEmpty
        ? vn.platforms.join(' / ').toUpperCase()
        : 'PC';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.surface, width: 1),
          bottom: BorderSide(color: AppTheme.surface, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            context,
            Icons.calendar_today_rounded,
            'RELEASE',
            vn.releaseYear,
          ),
          _buildItem(context, Icons.access_time_rounded, 'PLAYTIME', playtime),
          _buildItem(context, Icons.gamepad_outlined, 'PLATFORMS', platformStr),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.textMuted, size: 20),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
