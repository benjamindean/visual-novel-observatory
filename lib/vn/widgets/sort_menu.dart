import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import '../../theme/app_theme.dart';

class SortMenu extends ConsumerWidget {
  const SortMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortState = ref.watch(vnSortProvider);
    final notifier = ref.read(vnSortProvider.notifier);

    final sortFields = <String, String>{
      'rating': 'Rating',
      'votecount': 'Votes',
      'released': 'Release Date',
      'title': 'Title',
    };

    return Container(
      decoration: BoxDecoration(
        color: context.appSearchField,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            tooltip: 'Sort Options',
            onSelected: (field) {
              notifier.updateField(field);
            },
            itemBuilder: (context) {
              return sortFields.entries.map((entry) {
                final isSelected = entry.key == sortState.field;

                return PopupMenuItem<String>(
                  value: entry.key,
                  child: Row(
                    children: [
                      Text(
                        entry.value,
                        style: TextStyle(
                          color: isSelected
                              ? context.appAccentTeal
                              : context.appTextPrimary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (isSelected) ...[
                        const Spacer(),
                        Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: context.appAccentTeal,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sort_rounded,
                    size: 16,
                    color: context.appAccentTeal,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    sortFields[sortState.field] ?? 'Sort',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.appTextPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 16,
                    color: context.appTextSecondary,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 18,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          InkWell(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            onTap: () {
              notifier.toggleDirection();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(
                sortState.descending
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
                size: 16,
                color: context.appTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
