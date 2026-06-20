import 'package:flutter/material.dart';
import '../models/visual_novel.dart';
import '../utils/vndb_date_display.dart';
import '../../theme/app_theme.dart';
import 'metadata_item.dart';

class MetadataRow extends StatelessWidget {
  final VisualNovel vn;

  const MetadataRow({super.key, required this.vn});

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

    final formattedRelease = formatVndbDate(vn.released);

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
