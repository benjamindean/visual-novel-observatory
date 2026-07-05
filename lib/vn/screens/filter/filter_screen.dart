import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vn_providers.dart';
import '../../models/vn_tag.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';
import 'filter_section_header.dart';
import 'filter_chip_row.dart';
import 'filter_languages_tile.dart';
import 'filter_platforms_tile.dart';
import 'filter_release_date_range_tile.dart';
import 'filter_sort_row.dart';
import 'filter_tags_tile.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  List<String> _selectedLangs = [];
  List<String> _selectedPlatforms = [];
  List<int> _selectedLengths = [];
  List<int> _selectedDevStatuses = [];
  double _minRating = 7.0;
  int _minVotes = 50;
  String? _releasedFrom;
  String? _releasedTo;
  List<VnTag> _selectedTags = [];
  String _selectedSortField = 'rating';
  bool _selectedSortDescending = true;

  @override
  void initState() {
    super.initState();

    final currentFilters = ref.read(vnFilterProvider);
    final settings = ref.read(settingsProvider);
    final currentSort = ref.read(vnSortProvider);
    final tags = currentFilters.tags;

    _selectedLangs = List<String>.from(currentFilters.lang);
    _selectedPlatforms = List<String>.from(currentFilters.platform);
    _selectedLengths = List<int>.from(currentFilters.length);
    _selectedDevStatuses = List<int>.from(currentFilters.devStatus);
    _minRating = currentFilters.minRating;
    _minVotes = currentFilters.minVotes;
    _releasedFrom = currentFilters.releasedFrom;
    _releasedTo = currentFilters.releasedTo;
    _selectedSortField = currentSort.field;
    _selectedSortDescending = currentSort.descending;

    if (settings.blurSexualContent) {
      _selectedTags = tags.where((tag) => tag.category != 'ero').toList();
    } else {
      _selectedTags = List<VnTag>.from(tags);
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedLangs = const [];
      _selectedPlatforms = const [];
      _selectedLengths = const [];
      _selectedDevStatuses = const [];
      _minRating = 7.0;
      _minVotes = 50;
      _releasedFrom = null;
      _releasedTo = null;
      _selectedTags = const [];
      _selectedSortField = 'rating';
      _selectedSortDescending = true;
    });
  }

  void _applyFilters() {
    final settings = ref.read(settingsProvider);
    final tags = settings.blurSexualContent
        ? _selectedTags.where((tag) => tag.category != 'ero').toList()
        : _selectedTags;

    ref
        .read(vnFilterProvider.notifier)
        .update(
          VnFilterState(
            lang: _selectedLangs,
            platform: _selectedPlatforms,
            length: _selectedLengths,
            devStatus: _selectedDevStatuses,
            minRating: _minRating,
            minVotes: _minVotes,
            releasedFrom: _releasedFrom,
            releasedTo: _releasedTo,
            tags: tags,
          ),
        );

    ref
        .read(vnSortProvider.notifier)
        .updateSort(
          field: _selectedSortField,
          descending: _selectedSortDescending,
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
              // Sort Section
              const FilterSectionHeader(title: 'Sort By'),
              FilterSortRow(
                items: const {
                  'rating': 'Rating',
                  'votecount': 'Votes',
                  'released': 'Release Date',
                  'title': 'Title',
                },
                selectedField: _selectedSortField,
                isDescending: _selectedSortDescending,
                onChanged: (field, descending) {
                  setState(() {
                    _selectedSortField = field;
                    _selectedSortDescending = descending;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              Divider(
                color: context.appTextPrimary.withValues(alpha: 0.08),
                height: 1.0,
              ),
              const SizedBox(height: 20.0),

              // Language Section
              const FilterSectionHeader(title: 'Language'),
              FilterLanguagesTile(
                selectedLanguages: _selectedLangs,
                onLanguagesChanged: (languages) {
                  setState(() {
                    _selectedLangs = languages;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Platform Section
              const FilterSectionHeader(title: 'Platform'),
              FilterPlatformsTile(
                selectedPlatforms: _selectedPlatforms,
                onPlatformsChanged: (platforms) {
                  setState(() {
                    _selectedPlatforms = platforms;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Length Section
              const FilterSectionHeader(title: 'Play Time'),
              FilterChipRow<int>(
                items: const {
                  1: 'Very Short (<2h)',
                  2: 'Short (2-10h)',
                  3: 'Medium (10-30h)',
                  4: 'Long (30-50h)',
                  5: 'Very Long (>50h)',
                },
                selectedValues: _selectedLengths,
                onSelected: (vals) {
                  setState(() {
                    _selectedLengths = vals;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Dev Status Section
              const FilterSectionHeader(title: 'Development Status'),
              FilterChipRow<int>(
                items: const {0: 'Finished', 1: 'In Dev', 2: 'Cancelled'},
                selectedValues: _selectedDevStatuses,
                onSelected: (vals) {
                  setState(() {
                    _selectedDevStatuses = vals;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Release Date Section
              const FilterSectionHeader(title: 'Release Date'),
              FilterReleaseDateRangeTile(
                releasedFrom: _releasedFrom,
                releasedTo: _releasedTo,
                onFromChanged: (value) {
                  setState(() {
                    _releasedFrom = value;
                  });
                },
                onToChanged: (value) {
                  setState(() {
                    _releasedTo = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Tags Section
              const FilterSectionHeader(title: 'Tags'),
              FilterTagsTile(
                selectedTags: _selectedTags,
                onTagsChanged: (tags) {
                  setState(() {
                    _selectedTags = tags;
                  });
                },
              ),
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
      bottomNavigationBar: BottomActionBar(
        label: 'Apply Filters',
        onPressed: _applyFilters,
      ),
    );
  }
}
