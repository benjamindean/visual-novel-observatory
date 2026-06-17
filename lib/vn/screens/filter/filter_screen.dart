import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/vn_providers.dart';
import '../../models/vn_tag.dart';
import '../../../theme/app_theme.dart';
import '../../../settings/providers/settings_provider.dart';
import 'filter_section_header.dart';
import 'filter_chip_row.dart';
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
    _selectedSortField = currentSort.field;
    _selectedSortDescending = currentSort.descending;

    if (!settings.showExplicitContent) {
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
      _selectedTags = const [];
      _selectedSortField = 'rating';
      _selectedSortDescending = true;
    });
  }

  void _applyFilters() {
    final settings = ref.read(settingsProvider);
    final tags = settings.showExplicitContent
        ? _selectedTags
        : _selectedTags.where((tag) => tag.category != 'ero').toList();

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
              FilterChipRow<String>(
                items: const {
                  'en': 'English',
                  'ja': 'Japanese',
                  'zh': 'Chinese',
                  'es': 'Spanish',
                  'ko': 'Korean',
                },
                selectedValues: _selectedLangs,
                onSelected: (vals) {
                  setState(() {
                    _selectedLangs = vals;
                  });
                },
              ),
              const SizedBox(height: 20.0),

              // Platform Section
              const FilterSectionHeader(title: 'Platform'),
              FilterChipRow<String>(
                items: const {
                  'win': 'Windows',
                  'swi': 'Switch',
                  'ps4': 'PS4',
                  'and': 'Android',
                  'ios': 'iOS',
                },
                itemIcons: const {
                  'win': FontAwesomeIcons.windows,
                  'swi': FontAwesomeIcons.gamepad,
                  'ps4': FontAwesomeIcons.playstation,
                  'and': FontAwesomeIcons.android,
                  'ios': FontAwesomeIcons.apple,
                },
                selectedValues: _selectedPlatforms,
                onSelected: (vals) {
                  setState(() {
                    _selectedPlatforms = vals;
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
}
