import 'package:flutter/material.dart';
import '../models/visual_novel.dart';
import '../../theme/app_theme.dart';

class MetadataRow extends StatelessWidget {
  final VisualNovel vn;

  const MetadataRow({super.key, required this.vn});

  String _formatReleaseDate(String? released) {
    if (released == null || released == 'TBA') {
      return 'TBA';
    }

    try {
      final parts = released.split('-');

      if (parts.length == 3) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

        return '${months[month - 1]} $day, $year';
      } else if (parts.length == 2) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

        return '${months[month - 1]} $year';
      }
    } catch (_) {}

    return released;
  }

  @override
  Widget build(BuildContext context) {
    String playtime = 'Unknown';

    if (vn.lengthMinutes != null) {
      final hours = vn.lengthMinutes! ~/ 60;

      playtime = '$hours hrs';
    } else if (vn.length != null) {
      switch (vn.length) {
        case 1:
          playtime = '< 2 hrs';
          break;
        case 2:
          playtime = '2-10 hrs';
          break;
        case 3:
          playtime = '10-30 hrs';
          break;
        case 4:
          playtime = '30-50 hrs';
          break;
        case 5:
          playtime = '> 50 hrs';
          break;
        default:
          playtime = 'Unknown';
      }
    }

    final formattedRelease = _formatReleaseDate(vn.released);

    final developerName = vn.developers.isNotEmpty
        ? vn.developers.first.name
        : 'Unknown';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.appTextPrimary.withValues(alpha: 0.06),
            width: 1,
          ),
          bottom: BorderSide(
            color: context.appTextPrimary.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            context,
            Icons.calendar_today_rounded,
            'RELEASE DATE',
            formattedRelease,
          ),
          _buildItem(context, Icons.access_time_rounded, 'PLAYTIME', playtime),
          _buildItem(
            context,
            Icons.business_rounded,
            'DEVELOPER',
            developerName,
          ),
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
          Icon(icon, color: context.appTextMuted, size: 20),
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
              color: context.appTextPrimary,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
