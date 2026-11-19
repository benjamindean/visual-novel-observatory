import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import 'home_tab_label.dart';

class HomeBottomTabBar extends ConsumerWidget {
  const HomeBottomTabBar({
    super.key,
    required this.tabs,
  });

  final List<HomeTabDefinition> tabs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: context.appSurface,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.appTextPrimary.withValues(alpha: 0.08),
              width: 1.0,
            ),
          ),
        ),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: context.appAccentTeal,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: context.appAccentTeal,
          unselectedLabelColor: context.appTextMuted,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          onTap: (index) {
            if (tabs[index].id != HomeTabIds.createFilter) {
              return;
            }

            final selectedTabId = ref.read(homeTabsProvider).selectedTabId;
            final selectedIndex = tabs.indexWhere(
              (tab) => tab.id == selectedTabId,
            );

            context.push('/home/create-filter');

            if (selectedIndex != -1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  DefaultTabController.of(context).animateTo(selectedIndex);
                }
              });
            }
          },
          tabs: [
            for (final tab in tabs) HomeTabLabel(tab: tab),
          ],
        ),
      ),
    );
  }
}
