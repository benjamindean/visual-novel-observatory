import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/vn_providers.dart';

class HomeTabChangeListener extends ConsumerStatefulWidget {
  const HomeTabChangeListener({
    super.key,
    required this.tabs,
    required this.child,
  });

  final List<HomeTabDefinition> tabs;
  final Widget child;

  @override
  ConsumerState<HomeTabChangeListener> createState() {
    return HomeTabChangeListenerState();
  }
}

class HomeTabChangeListenerState extends ConsumerState<HomeTabChangeListener> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = DefaultTabController.of(context);

    if (_controller != newController) {
      _controller?.removeListener(_onTabChanged);
      _controller = newController;
      _controller?.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    final controller = _controller;

    if (controller == null || controller.indexIsChanging) {
      return;
    }

    final index = controller.index;

    if (index < 0 || index >= widget.tabs.length) {
      return;
    }

    final tabId = widget.tabs[index].id;

    if (tabId == HomeTabIds.createFilter) {
      final selectedTabId = ref.read(homeTabsProvider).selectedTabId;
      final selectedIndex = widget.tabs.indexWhere(
        (tab) => tab.id == selectedTabId,
      );

      if (selectedIndex != -1) {
        controller.animateTo(selectedIndex);
      }

      return;
    }

    ref.read(homeTabsProvider.notifier).selectTab(tabId);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
