import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/vn_tag.dart';
import '../../providers/vn_providers.dart';
import '../../widgets/app_search_input.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/filter_selectable_list_tile.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';
import 'tag_filter_caching_placeholder.dart';

class TagFilterScreen extends ConsumerStatefulWidget {
  final List<VnTag> initialTags;

  const TagFilterScreen({super.key, required this.initialTags});

  @override
  ConsumerState<TagFilterScreen> createState() => _TagFilterScreenState();
}

class _TagFilterScreenState extends ConsumerState<TagFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<VnTag> _selectedTags = [];
  final Set<String> _selectedTagIds = {};

  List<VnTag> _searchResults = [];

  @override
  void initState() {
    super.initState();

    final initial = widget.initialTags;
    final settings = ref.read(settingsProvider);

    if (settings.blurSexualContent) {
      _selectedTags.addAll(
        initial.where((tag) => tag.category != 'ero').toList(),
      );
    } else {
      _selectedTags.addAll(initial);
    }

    _selectedTagIds.addAll(_selectedTags.map((tag) => tag.id));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });

      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final settings = ref.read(settingsProvider);
    final rawTags = ref.read(localTagsProvider).tags;
    final allTags = settings.blurSexualContent
        ? rawTags.where((tag) => tag.category != 'ero').toList()
        : rawTags;

    final results = allTags
        .where(
          (tag) =>
              tag.name.toLowerCase().contains(lowercaseQuery) ||
              tag.id.toLowerCase().contains(lowercaseQuery),
        )
        .toList();

    setState(() {
      _searchResults = results;
    });
  }

  void _toggleTag(VnTag tag) {
    setState(() {
      if (_selectedTagIds.remove(tag.id)) {
        _selectedTags.removeWhere((t) => t.id == tag.id);
      } else {
        _selectedTagIds.add(tag.id);
        _selectedTags.add(tag);
      }
    });

    if (_searchController.text.isNotEmpty) {
      _performSearch(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final blurSexualContent = ref.watch(
      settingsProvider.select((settings) => settings.blurSexualContent),
    );
    final localTagsState = ref.watch(
      localTagsProvider.select(
        (state) => (
          tags: state.tags,
          isLoading: state.isLoading,
          progress: state.progress,
        ),
      ),
    );
    final initialTags = _searchController.text.isEmpty
        ? localTagsState.tags
        : _searchResults;

    final filteredTags = blurSexualContent
        ? initialTags.where((tag) => tag.category != 'ero').toList()
        : initialTags;

    final displayTags = [
      ...filteredTags.where((tag) => _selectedTagIds.contains(tag.id)),
      ...filteredTags.where((tag) => !_selectedTagIds.contains(tag.id)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter by Tags',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: _selectedTags.isEmpty
                ? null
                : () {
                    setState(() {
                      _selectedTags.clear();
                      _selectedTagIds.clear();
                    });

                    if (_searchController.text.isNotEmpty) {
                      _performSearch(_searchController.text);
                    }
                  },
            child: Text(
              'Clear',
              style: TextStyle(color: context.colorScheme.error),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar:
          localTagsState.isLoading && localTagsState.tags.isEmpty
          ? null
          : BottomActionBar(
              label: 'Save Tags',
              badgeCount: _selectedTagIds.length,
              onPressed: () {
                Navigator.of(context).pop(_selectedTags);
              },
            ),
      body: localTagsState.isLoading && localTagsState.tags.isEmpty
          ? TagFilterCachingPlaceholder(progress: localTagsState.progress)
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Search results
                    Expanded(
                      child: displayTags.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.tag_rounded,
                                    size: 64,
                                    color: context.appTextMuted,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'No tags loaded'
                                        : 'No tags found matching "${_searchController.text}"',
                                    style: TextStyle(
                                      color: context.appTextMuted,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                16.0,
                                8.0,
                                16.0,
                                64.0,
                              ),
                              itemCount: displayTags.length,
                              itemBuilder: (context, index) {
                                final tag = displayTags[index];
                                final isSelected = _selectedTagIds.contains(
                                  tag.id,
                                );

                                return FilterSelectableListTile(
                                  leading: Icon(
                                    Icons.tag_rounded,
                                    size: 18,
                                    color: isSelected
                                        ? context.colorScheme.onPrimaryContainer
                                        : context.appTextSecondary,
                                  ),
                                  title: tag.name,
                                  isSelected: isSelected,
                                  onTap: () => _toggleTag(tag),
                                );
                              },
                            ),
                    ),
                  ],
                ),
                // Floating organic bottom search bar (thumb-stretch aware)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: AppSearchInput(
                      controller: _searchController,
                      onChanged: _performSearch,
                      hintText:
                          'Search tags (e.g. Magic, Female Protagonist)...',
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
