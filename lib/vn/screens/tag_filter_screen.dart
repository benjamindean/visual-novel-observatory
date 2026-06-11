import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vn_tag.dart';
import '../providers/vn_providers.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class TagFilterScreen extends ConsumerStatefulWidget {
  final List<VnTag> initialTags;

  const TagFilterScreen({super.key, required this.initialTags});

  @override
  ConsumerState<TagFilterScreen> createState() => _TagFilterScreenState();
}

class _TagFilterScreenState extends ConsumerState<TagFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<VnTag> _selectedTags = [];

  List<VnTag> _searchResults = [];

  @override
  void initState() {
    super.initState();

    final initial = widget.initialTags;
    final settings = ref.read(settingsProvider);

    if (!settings.showExplicitContent) {
      _selectedTags.addAll(
        initial.where((tag) => tag.category != 'ero').toList(),
      );
    } else {
      _selectedTags.addAll(initial);
    }
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

    var allTags = ref.read(localTagsProvider).tags;

    if (!settings.showExplicitContent) {
      allTags = allTags.where((tag) => tag.category != 'ero').toList();
    }

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
      final exists = _selectedTags.any((t) => t.id == tag.id);

      if (exists) {
        _selectedTags.removeWhere((t) => t.id == tag.id);
      } else {
        _selectedTags.add(tag);
      }
    });

    if (_searchController.text.isNotEmpty) {
      _performSearch(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final localTagsState = ref.watch(localTagsProvider);

    var displayTags = _searchController.text.isEmpty
        ? localTagsState.tags
        : _searchResults;

    if (!settings.showExplicitContent) {
      displayTags = displayTags.where((tag) => tag.category != 'ero').toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter by Tags',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: localTagsState.isLoading && localTagsState.tags.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: context.appAccentTeal),
                    const SizedBox(height: 20),
                    Text(
                      'Caching tags database locally...\n${(localTagsState.progress * 100).toStringAsFixed(0)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.appTextSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This only happens once. Subsequent tag searches will be instant.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.appTextMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search Input Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _performSearch,
                    decoration: InputDecoration(
                      hintText:
                          'Search tags (e.g. Magic, Female Protagonist)...',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: context.appTextMuted,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear_rounded,
                                color: context.appTextMuted,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                // Selected Tags wrap section
                if (_selectedTags.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'SELECTED TAGS (${_selectedTags.length})',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appTextMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 120),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _selectedTags.map((tag) {
                          return InputChip(
                            label: Text(tag.name),
                            onDeleted: () => _toggleTag(tag),
                            deleteIcon: const Icon(
                              Icons.cancel_rounded,
                              size: 16,
                              color: Colors.white70,
                            ),
                            backgroundColor: context.appAccentTeal.withValues(
                              alpha: 0.15,
                            ),
                            labelStyle: TextStyle(
                              color: context.appAccentTeal,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            side: BorderSide(
                              color: context.appAccentTeal,
                              width: 0.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: Colors.white10, height: 24),
                  ),
                ],

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
                                color: context.appTextMuted.withValues(
                                  alpha: 0.5,
                                ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          itemCount: displayTags.length,
                          itemBuilder: (context, index) {
                            final tag = displayTags[index];
                            final isSelected = _selectedTags.any(
                              (t) => t.id == tag.id,
                            );

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Material(
                                color: isSelected
                                    ? context.appSurface.withValues(alpha: 0.5)
                                    : context.appSurface,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? context.appAccentTeal.withValues(
                                            alpha: 0.4,
                                          )
                                        : Colors.white.withValues(alpha: 0.04),
                                  ),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? context.appAccentTeal.withValues(
                                              alpha: 0.1,
                                            )
                                          : Colors.white.withValues(
                                              alpha: 0.03,
                                            ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.tag_rounded,
                                      size: 18,
                                      color: isSelected
                                          ? context.appAccentTeal
                                          : context.appTextSecondary,
                                    ),
                                  ),
                                  title: Text(
                                    tag.name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : context.appTextPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    activeColor: context.appAccentTeal,
                                    checkColor: Colors.black,
                                    value: isSelected,
                                    onChanged: (_) => _toggleTag(tag),
                                  ),
                                  onTap: () => _toggleTag(tag),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appAccentTeal,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(_selectedTags);
                    },
                    child: const Text(
                      'Save Tags',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
