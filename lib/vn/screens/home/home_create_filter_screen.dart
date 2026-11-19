import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../../theme/app_theme.dart';
import '../../providers/vn_providers.dart';
import '../../widgets/bottom_action_bar.dart';
import 'widgets/home_create_filter_tab.dart';

class HomeCreateFilterScreen extends ConsumerStatefulWidget {
  const HomeCreateFilterScreen({
    super.key,
    this.tabId,
  });

  final String? tabId;

  @override
  ConsumerState<HomeCreateFilterScreen> createState() {
    return HomeCreateFilterScreenState();
  }
}

class HomeCreateFilterScreenState
    extends ConsumerState<HomeCreateFilterScreen> {
  final GlobalKey<HomeCreateFilterTabState> _filterKey =
      GlobalKey<HomeCreateFilterTabState>();

  Future<void> _removeTab(HomeTabDefinition tab) async {
    final shouldRemove = await showAppConfirmationDialog(
      context: context,
      title: 'Remove filter tab?',
      message: 'Remove "${tab.title}" from Home?',
      confirmLabel: 'Remove',
    );

    if (!shouldRemove || !mounted) {
      return;
    }

    await ref.read(homeTabsProvider.notifier).removeCustomTab(tab.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabId = widget.tabId;
    final tab = tabId == null
        ? null
        : ref.watch(homeTabDefinitionProvider(tabId));
    final isEditing = tabId != null;

    if (isEditing && tab == null) {
      return Scaffold(
        backgroundColor: context.appBackground,
        appBar: AppBar(
          title: const Text('Edit Filter'),
          backgroundColor: context.appBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: const Center(
          child: Text('Filter not found.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Filter' : 'New Filter'),
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: () {
              _filterKey.currentState?.resetFilters();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          if (tab != null)
            IconButton(
              tooltip: 'Remove',
              onPressed: () => _removeTab(tab),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: context.colorScheme.error,
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: HomeCreateFilterTab(
        key: _filterKey,
        initialTab: tab,
      ),
      bottomNavigationBar: BottomActionBar(
        label: isEditing ? 'Save Changes' : 'Create Tab',
        icon: isEditing ? Icons.check_rounded : Icons.add_rounded,
        onPressed: () {
          _filterKey.currentState?.submitTab();
        },
      ),
    );
  }
}
