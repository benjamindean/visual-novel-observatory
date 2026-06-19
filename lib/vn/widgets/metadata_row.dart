import 'package:flutter/material.dart';
import '../models/visual_novel.dart';
import '../../theme/app_theme.dart';
import 'metadata_item.dart';

class MetadataRow extends StatelessWidget {
  final VisualNovel vn;

  const MetadataRow({super.key, required this.vn});

  static const _months = [
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

  String _formatReleaseDate(String? released) {
    if (released == null || released == 'TBA') {
      return 'TBA';
    }

    final parts = released.split('-');

    if (parts.length == 3) {
      final year = parts[0];
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);

      if (month != null && month >= 1 && month <= 12 && day != null) {
        return '${_months[month - 1]} $day, $year';
      }
    } else if (parts.length == 2) {
      final year = parts[0];
      final month = int.tryParse(parts[1]);

      if (month != null && month >= 1 && month <= 12) {
        return '${_months[month - 1]} $year';
      }
    }

    return released;
  }

  @override
  Widget build(BuildContext context) {
    String playtime = 'Unknown';
    String? playtimeTooltip;

    if (vn.lengthMinutes != null) {
      final hours = vn.lengthMinutes! ~/ 60;

      playtime = '$hours hrs';
      playtimeTooltip = vn.lengthVotes != null && vn.lengthVotes! > 0
          ? 'Average playtime from ${vn.lengthVotes} submitted playtime votes.'
          : 'Average user-submitted playtime.';
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

      playtimeTooltip = 'Estimated length category: ${vn.playLengthLabel}.';
    }

    final formattedRelease = _formatReleaseDate(vn.released);

    final developerName = vn.developers.isNotEmpty
        ? vn.developers.first.name
        : 'Unknown';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.theme.dividerColor, width: 1),
          bottom: BorderSide(color: context.theme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MetadataItem(
            icon: Icons.calendar_today_rounded,
            label: 'RELEASE DATE',
            value: formattedRelease,
            iconColor: context.colorScheme.tertiary,
          ),
          MetadataItem(
            icon: Icons.access_time_rounded,
            label: 'PLAYTIME',
            value: playtime,
            iconColor: context.colorScheme.tertiary,
            tooltipMessage: playtimeTooltip,
          ),
          MetadataItem(
            icon: Icons.business_rounded,
            label: 'DEVELOPER',
            value: developerName,
            iconColor: context.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
