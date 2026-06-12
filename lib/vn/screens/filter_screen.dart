import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/vn_providers.dart';
import '../models/vn_tag.dart';
import 'tag_filter_screen.dart';
import '../../theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  String? _selectedLang;
  String? _selectedPlatform;
  int? _selectedLength;
  int? _selectedDevStatus;
  double _minRating = 7.0;
  int _minVotes = 50;
  List<VnTag> _selectedTags = [];

  @override
  void initState() {
    super.initState();

    final currentFilters = ref.read(vnFilterProvider);
    final settings = ref.read(settingsProvider);
    final tags = currentFilters.tags;

    _selectedLang = currentFilters.lang;
    _selectedPlatform = currentFilters.platform;
    _selectedLength = currentFilters.length;
    _selectedDevStatus = currentFilters.devStatus;
    _minRating = currentFilters.minRating;
    _minVotes = currentFilters.minVotes;

    if (!settings.showExplicitContent) {
      _selectedTags = tags.where((tag) => tag.category != 'ero').toList();
    } else {
      _selectedTags = List<VnTag>.from(tags);
    }
  }

  void _resetFilters() {
    final settings = ref.read(settingsProvider);

    setState(() {
      _selectedLang = settings.defaultLanguage;
      _selectedPlatform = settings.defaultPlatform;
      _selectedLength = null;
      _selectedDevStatus = null;
      _minRating = 7.0;
      _minVotes = 50;
      _selectedTags = [];
    });
  }

  void _applyFilters() {
    final showExplicit = ref.read(vnFilterProvider).showExplicitContent;
    final tags = showExplicit
        ? _selectedTags
        : _selectedTags.where((tag) => tag.category != 'ero').toList();

    ref
        .read(vnFilterProvider.notifier)
        .update(
          VnFilterState(
            lang: _selectedLang,
            platform: _selectedPlatform,
            length: _selectedLength,
            devStatus: _selectedDevStatus,
            minRating: _minRating,
            minVotes: _minVotes,
            showExplicitContent: showExplicit,
            tags: tags,
          ),
        );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        title: const Text('Filter Visual Novels'),
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset All',
              style: TextStyle(color: context.colorScheme.error),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              // Language Section
              _buildSectionHeader(context, 'Language'),
              _buildChipRow<String>(
                context,
                items: {
                  'en': 'English',
                  'ja': 'Japanese',
                  'zh': 'Chinese',
                  'es': 'Spanish',
                  'ko': 'Korean',
                },
                selectedValue: _selectedLang,
                onSelected: (val) {
                  setState(() {
                    _selectedLang = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Platform Section
              _buildSectionHeader(context, 'Platform'),
              _buildChipRow<String>(
                context,
                items: {
                  'win': 'Windows',
                  'swi': 'Switch',
                  'ps4': 'PS4',
                  'and': 'Android',
                  'ios': 'iOS',
                },
                selectedValue: _selectedPlatform,
                onSelected: (val) {
                  setState(() {
                    _selectedPlatform = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Length Section
              _buildSectionHeader(context, 'Play Time'),
              _buildChipRow<int>(
                context,
                items: {
                  1: 'Very Short (<2h)',
                  2: 'Short (2-10h)',
                  3: 'Medium (10-30h)',
                  4: 'Long (30-50h)',
                  5: 'Very Long (>50h)',
                },
                selectedValue: _selectedLength,
                onSelected: (val) {
                  setState(() {
                    _selectedLength = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Dev Status Section
              _buildSectionHeader(context, 'Development Status'),
              _buildChipRow<int>(
                context,
                items: {0: 'Finished', 1: 'In Dev', 2: 'Cancelled'},
                selectedValue: _selectedDevStatus,
                onSelected: (val) {
                  setState(() {
                    _selectedDevStatus = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Tags Section
              _buildSectionHeader(context, 'Tags'),
              _buildTagsTile(context),
              const SizedBox(height: 24.0),

              // Rating Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum Rating',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_minRating.toStringAsFixed(1)} / 10.0',
                    style: TextStyle(
                      color: context.appAccentTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _minRating,
                min: 0.0,
                max: 10.0,
                divisions: 100,
                activeColor: context.appAccentTeal,
                inactiveColor: context.appSurface,
                onChanged: (val) {
                  setState(() {
                    _minRating = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Vote Count Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum Votes',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_minVotes votes',
                    style: TextStyle(
                      color: context.appAccentTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _minVotes.toDouble(),
                min: 0,
                max: 500,
                divisions: 50,
                activeColor: context.appAccentTeal,
                inactiveColor: context.appSurface,
                onChanged: (val) {
                  setState(() {
                    _minVotes = val.round();
                  });
                },
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appAccentTeal,
              foregroundColor: context.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            onPressed: _applyFilters,
            child: const Text(
              'Apply Filters',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildChipRow<T>(
    BuildContext context, {
    required Map<T, String> items,
    required T? selectedValue,
    required ValueChanged<T?> onSelected,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.entries.map((entry) {
          final isSelected = entry.key == selectedValue;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(selected ? entry.key : null);
              },
              backgroundColor: context.appSurface,
              selectedColor: context.appAccentTeal,
              checkmarkColor: context.colorScheme.onPrimary,
              labelStyle: TextStyle(
                color: isSelected
                    ? context.colorScheme.onPrimary
                    : context.appTextPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTagsTile(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push<List<VnTag>>(
              MaterialPageRoute(
                builder: (context) =>
                    TagFilterScreen(initialTags: _selectedTags),
              ),
            )
            .then((result) {
              if (result != null) {
                setState(() {
                  _selectedTags = result;
                });
              }
            });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedTags.isEmpty)
                    Text(
                      'Select Tags...',
                      style: TextStyle(
                        color: context.appTextSecondary,
                        fontSize: 14,
                      ),
                    )
                  else
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _selectedTags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tag.name,
                            style: TextStyle(
                              color: context.appAccentTeal,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: context.appTextMuted),
          ],
        ),
      ),
    );
  }
}
