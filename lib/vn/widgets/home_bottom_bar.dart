import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import 'filter_sheet.dart';
import 'sort_menu.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

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
    final settings = ref.watch(settingsProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final hasActiveFilters =
        filters.lang != settings.defaultLanguage ||
        filters.platform != settings.defaultPlatform ||
        filters.length != null ||
        filters.devStatus != null ||
        filters.minRating != 7.0 ||
        filters.minVotes != 50 ||
        filters.tags.isNotEmpty;

    if (_searchController.text != searchQuery) {
      _searchController.text = searchQuery;
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
                            color: context.colorScheme.primaryContainer
                                .withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.2,
                              ),
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
                            color: context.colorScheme.primaryContainer
                                .withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.2,
                              ),
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
                                color: hasActiveFilters
                                    ? context.colorScheme.secondaryContainer
                                          .withValues(alpha: 0.6)
                                    : context.colorScheme.primaryContainer
                                          .withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: hasActiveFilters
                                      ? context.colorScheme.secondary
                                            .withValues(alpha: 0.4)
                                      : context.colorScheme.primary.withValues(
                                          alpha: 0.2,
                                        ),
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
}
