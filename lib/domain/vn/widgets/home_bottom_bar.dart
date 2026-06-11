import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import '../models/vn_tag.dart';
import 'filter_sheet.dart';
import 'sort_menu.dart';
import '../../../theme/app_theme.dart';

class HomeBottomBar extends ConsumerStatefulWidget {
  const HomeBottomBar({super.key});

  @override
  ConsumerState<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends ConsumerState<HomeBottomBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    final searchQuery = ref.read(searchQueryProvider);

    _searchController.text = searchQuery;
    if (searchQuery.isNotEmpty) {
      _isSearchActive = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(vnFilterProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final activeChips = <Widget>[];
    final hasActiveFilters = !filters.isEmpty;

    if (_searchController.text != searchQuery) {
      _searchController.text = searchQuery;
    }

    if (filters.lang != null) {
      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Lang: ${filters.lang!.toUpperCase()}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(lang: () => null));
          },
        ),
      );
    }

    if (filters.platform != null) {
      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Platform: ${filters.platform!.toUpperCase()}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(platform: () => null));
          },
        ),
      );
    }

    if (filters.length != null) {
      final lengths = {
        1: '< 2h',
        2: '2-10h',
        3: '10-30h',
        4: '30-50h',
        5: '> 50h',
      };

      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Length: ${lengths[filters.length]}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(length: () => null));
          },
        ),
      );
    }

    if (filters.devStatus != null) {
      final statuses = {0: 'Finished', 1: 'In Dev', 2: 'Cancelled'};

      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Status: ${statuses[filters.devStatus]}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(devStatus: () => null));
          },
        ),
      );
    }

    if (filters.minRating != 7.0) {
      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Rating >= ${filters.minRating.toStringAsFixed(1)}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(minRating: 7.0));
          },
        ),
      );
    }

    if (filters.minVotes != 50) {
      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Votes >= ${filters.minVotes}',
          onDeleted: () {
            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(minVotes: 50));
          },
        ),
      );
    }

    for (final tag in filters.tags) {
      activeChips.add(
        _buildActiveFilterChip(
          context,
          label: 'Tag: ${tag.name}',
          onDeleted: () {
            final newTags = List<VnTag>.from(filters.tags)..remove(tag);

            ref
                .read(vnFilterProvider.notifier)
                .update(filters.copyWith(tags: newTags));
          },
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (activeChips.isNotEmpty)
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.05),
                      width: 1,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: activeChips),
                ),
              ),
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _isSearchActive
                  ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            onChanged: (val) {
                              ref
                                  .read(searchQueryProvider.notifier)
                                  .update(val);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search a title...',
                              prefixIcon: const Icon(Icons.search_rounded),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear_rounded),
                                      onPressed: () {
                                        _searchController.clear();
                                        ref
                                            .read(searchQueryProvider.notifier)
                                            .update('');
                                      },
                                    )
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: context.appSearchField,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: context.appTextPrimary,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearchActive = false;
                                _searchController.clear();
                              });
                              ref.read(searchQueryProvider.notifier).update('');
                            },
                            tooltip: 'Close Search',
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const SortMenu(),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: context.appSearchField,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: context.appTextPrimary,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearchActive = true;
                              });
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () {
                                  _searchFocusNode.requestFocus();
                                },
                              );
                            },
                            tooltip: 'Search',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: context.appSearchField,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.05),
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.tune_rounded,
                                  color: hasActiveFilters
                                      ? context.appAccentAmber
                                      : context.appTextPrimary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const FilterSheet(),
                                  );
                                },
                                tooltip: 'Filters',
                              ),
                            ),
                            if (hasActiveFilters)
                              Positioned(
                                top: -2,
                                right: -2,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: context.appAccentAmber,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilterChip(
    BuildContext context, {
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InputChip(
        label: Text(label),
        onDeleted: onDeleted,
        deleteIcon: Icon(
          Icons.close,
          size: 14,
          color: context.appTextPrimary.withValues(alpha: 0.7),
        ),
        backgroundColor: context.appSearchField,
        labelStyle: TextStyle(color: context.appTextPrimary, fontSize: 12),
        side: BorderSide(color: context.appTextPrimary.withValues(alpha: 0.08)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
