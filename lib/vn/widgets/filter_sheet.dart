import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vn_providers.dart';
import '../models/vn_tag.dart';
import '../screens/tag_filter_screen.dart';
import '../../theme/app_theme.dart';

class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key});

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
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

    _selectedLang = currentFilters.lang;
    _selectedPlatform = currentFilters.platform;
    _selectedLength = currentFilters.length;
    _selectedDevStatus = currentFilters.devStatus;
    _minRating = currentFilters.minRating;
    _minVotes = currentFilters.minVotes;
    _selectedTags = List<VnTag>.from(currentFilters.tags);
  }

  void _resetFilters() {
    setState(() {
      _selectedLang = null;
      _selectedPlatform = null;
      _selectedLength = null;
      _selectedDevStatus = null;
      _minRating = 7.0;
      _minVotes = 50;
      _selectedTags = [];
    });
  }

  void _applyFilters() {
    final showExplicit = ref.read(vnFilterProvider).showExplicitContent;

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
            tags: _selectedTags,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: context.appBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle/Indicator bar
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Visual Novels',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _resetFilters,
                child: const Text(
                  'Reset All',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Scrollable Filter Sections
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 16.0),

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
                  const SizedBox(height: 16.0),

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
                  const SizedBox(height: 16.0),

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
                  const SizedBox(height: 16.0),

                  // Tags Section
                  _buildSectionHeader(context, 'Tags'),
                  _buildTagsTile(context),
                  const SizedBox(height: 20.0),

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
                  const SizedBox(height: 12.0),

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
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Apply Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appAccentTeal,
              foregroundColor: Colors.black,
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
        ],
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
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : context.appTextSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
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
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                            color: context.appAccentTeal.withValues(
                              alpha: 0.15,
                            ),
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
