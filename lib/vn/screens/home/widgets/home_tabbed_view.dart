import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../providers/vn_providers.dart';
import 'home_bottom_tab_bar.dart';
import 'home_tab_change_listener.dart';
import 'home_vn_tab_view.dart';
import 'home_sliver_app_bar.dart';

class HomeTabbedView extends ConsumerWidget {
  const HomeTabbedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeTabsState = ref.watch(homeTabsProvider);
    final tabs = homeTabsState.tabs;
    final selectedIndex = tabs.indexWhere(
      (tab) => tab.id == homeTabsState.selectedTabId,
    );
    final initialIndex = selectedIndex == -1 ? 0 : selectedIndex;
    final tabKey = ValueKey(
      '${tabs.map((tab) => tab.id).join(',')}:$initialIndex',
    );

    return DefaultTabController(
      key: tabKey,
      length: tabs.length,
      initialIndex: initialIndex,
      child: HomeTabChangeListener(
        tabs: tabs,
        child: Scaffold(
          backgroundColor: context.appBackground,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return const [
                HomeSliverAppBar(),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final tab in tabs)
                  if (tab.id == HomeTabIds.createFilter)
                    const SizedBox.shrink()
                  else
                    HomeVnTabView(tab: tab),
              ],
            ),
          ),
          bottomNavigationBar: HomeBottomTabBar(tabs: tabs),
        ),
      ),
    );
  }
}
