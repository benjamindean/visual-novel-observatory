import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../constants/vndb_platforms.dart';
import '../../widgets/app_search_input.dart';
import '../../widgets/bottom_action_bar.dart';
import 'widgets/platform_filter_empty_state.dart';
import 'widgets/platform_filter_group.dart';

class PlatformFilterScreen extends StatefulWidget {
  const PlatformFilterScreen({
    super.key,
    required this.initialPlatformIds,
  });

  final List<String> initialPlatformIds;

  @override
  State<PlatformFilterScreen> createState() => PlatformFilterScreenState();
}

class PlatformFilterScreenState extends State<PlatformFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedPlatformIds = {};

  String _query = '';

  @override
  void initState() {
    super.initState();

    _selectedPlatformIds.addAll(widget.initialPlatformIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _setQuery(String query) {
    setState(() {
      _query = query.trim().toLowerCase();
    });
  }

  void _togglePlatform(VndbPlatform platform) {
    setState(() {
      if (!_selectedPlatformIds.remove(platform.id)) {
        _selectedPlatformIds.add(platform.id);
      }
    });
  }

  List<String> _orderedSelection() {
    return vndbPlatforms
        .where((platform) => _selectedPlatformIds.contains(platform.id))
        .map((platform) => platform.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayPlatforms = _query.isEmpty
        ? vndbPlatforms
        : vndbPlatforms.where((platform) {
            return platform.id.contains(_query) ||
                platform.label.toLowerCase().contains(_query) ||
                platform.group.toLowerCase().contains(_query);
          }).toList();
    final groupedPlatforms = <String, List<VndbPlatform>>{};

    for (final platform in displayPlatforms) {
      groupedPlatforms.putIfAbsent(platform.group, () => []).add(platform);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter by Platforms',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: _selectedPlatformIds.isEmpty
                ? null
                : () {
                    setState(_selectedPlatformIds.clear);
                  },
            child: Text(
              'Clear',
              style: TextStyle(color: context.colorScheme.error),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        label: 'Save Platforms',
        onPressed: () {
          Navigator.of(context).pop(_orderedSelection());
        },
      ),
      body: Stack(
        children: [
          displayPlatforms.isEmpty
              ? PlatformFilterEmptyState(query: _searchController.text)
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    8.0,
                    16.0,
                    54.0,
                  ),
                  children: groupedPlatforms.entries.map((entry) {
                    return PlatformFilterGroup(
                      title: entry.key,
                      platforms: entry.value,
                      selectedPlatformIds: _selectedPlatformIds,
                      onPlatformTap: _togglePlatform,
                    );
                  }).toList(),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: AppSearchInput(
                controller: _searchController,
                onChanged: _setQuery,
                hintText: 'Search platforms...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
