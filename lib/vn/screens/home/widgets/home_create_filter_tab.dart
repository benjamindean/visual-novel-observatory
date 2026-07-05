import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/providers/settings_provider.dart';
import '../../../../theme/app_theme.dart';
import '../../../models/vn_tag.dart';
import '../../../providers/vn_providers.dart';
import '../../filter/filter_chip_row.dart';
import '../../filter/filter_languages_tile.dart';
import '../../filter/filter_platforms_tile.dart';
import '../../filter/filter_release_date_range_tile.dart';
import '../../filter/filter_sort_row.dart';
import '../../filter/filter_tags_tile.dart';
import 'home_filter_form_section.dart';
import 'home_filter_name_field.dart';
import 'home_filter_slider_field.dart';

class HomeCreateFilterTab extends ConsumerStatefulWidget {
  const HomeCreateFilterTab({
    super.key,
    this.initialTab,
  });

  final HomeTabDefinition? initialTab;

  @override
  ConsumerState<HomeCreateFilterTab> createState() {
    return HomeCreateFilterTabState();
  }
}

class HomeCreateFilterTabState extends ConsumerState<HomeCreateFilterTab> {
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _applyFieldsFromTab(widget.initialTab);
  }

  @override
  void didUpdateWidget(covariant HomeCreateFilterTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTab?.id == widget.initialTab?.id) {
      return;
    }

    setState(() {
      _applyFieldsFromTab(widget.initialTab);
    });
  }

  void resetFilters() {
    setState(() {
      _applyFieldsFromTab(widget.initialTab);
    });
  }

  Future<void> submitTab() {
    return _submitTab();
  }

  void _applyFieldsFromTab(HomeTabDefinition? tab) {
    final filters = tab?.filters;
    final sort = tab?.sort;

    _nameController.text = tab?.title ?? '';
    _selectedLangs = List<String>.from(filters?.lang ?? const []);
    _selectedPlatforms = List<String>.from(filters?.platform ?? const []);
    _selectedLengths = List<int>.from(filters?.length ?? const []);
    _selectedDevStatuses = List<int>.from(filters?.devStatus ?? const []);
    _minRating = filters?.minRating ?? 7.0;
    _minVotes = filters?.minVotes ?? 50;
    _releasedFrom = filters?.releasedFrom;
    _releasedTo = filters?.releasedTo;
    _selectedTags = List<VnTag>.from(filters?.tags ?? const []);
    _selectedSortField = sort?.field ?? 'rating';
    _selectedSortDescending = sort?.descending ?? true;
  }

  Future<void> _submitTab() async {
    final settings = ref.read(settingsProvider);
    final tags = settings.blurSexualContent
        ? _selectedTags.where((tag) => tag.category != 'ero').toList()
        : _selectedTags;
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Name this filter before creating a tab.'),
          backgroundColor: context.colorScheme.error,
        ),
      );

      return;
    }

    final filters = VnFilterState(
      lang: _selectedLangs,
      platform: _selectedPlatforms,
      length: _selectedLengths,
      devStatus: _selectedDevStatuses,
      minRating: _minRating,
      minVotes: _minVotes,
      releasedFrom: _releasedFrom,
      releasedTo: _releasedTo,
      tags: tags,
    );
    final sort = VnSortState(
      field: _selectedSortField,
      descending: _selectedSortDescending,
    );
    final initialTab = widget.initialTab;

    if (initialTab == null) {
      await ref
          .read(homeTabsProvider.notifier)
          .addCustomTab(name: name, filters: filters, sort: sort);
    } else {
      await ref
          .read(homeTabsProvider.notifier)
          .updateCustomTab(
            tabId: initialTab.id,
            name: name,
            filters: filters,
            sort: sort,
          );
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeFilterNameField(
                    controller: _nameController,
                  ),
                  const SizedBox(height: 12.0),
                  HomeFilterFormSection(
                    title: 'Sort Order',
                    icon: Icons.sort_rounded,
                    child: FilterSortRow(
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
                  ),
                  const SizedBox(height: 12.0),
                  HomeFilterFormSection(
                    title: 'Availability',
                    icon: Icons.public_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Language',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        FilterLanguagesTile(
                          selectedLanguages: _selectedLangs,
                          onLanguagesChanged: (languages) {
                            setState(() {
                              _selectedLangs = languages;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Platform',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        FilterPlatformsTile(
                          selectedPlatforms: _selectedPlatforms,
                          onPlatformsChanged: (platforms) {
                            setState(() {
                              _selectedPlatforms = platforms;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  HomeFilterFormSection(
                    title: 'Main Details',
                    icon: Icons.tune_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Play Time',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
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
                        const SizedBox(height: 16.0),
                        Text(
                          'Development Status',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        FilterChipRow<int>(
                          items: const {
                            0: 'Finished',
                            1: 'In Dev',
                            2: 'Cancelled',
                          },
                          selectedValues: _selectedDevStatuses,
                          onSelected: (vals) {
                            setState(() {
                              _selectedDevStatuses = vals;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Release Date',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
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
                        const SizedBox(height: 16.0),
                        Text(
                          'Tags',
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.appTextSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        FilterTagsTile(
                          selectedTags: _selectedTags,
                          onTagsChanged: (tags) {
                            setState(() {
                              _selectedTags = tags;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  HomeFilterFormSection(
                    title: 'Score & Popularity',
                    icon: Icons.insights_rounded,
                    child: Column(
                      children: [
                        HomeFilterSliderField(
                          title: 'Minimum Rating',
                          valueLabel: '${_minRating.toStringAsFixed(1)} / 10.0',
                          value: _minRating,
                          min: 0.0,
                          max: 10.0,
                          divisions: 100,
                          onChanged: (val) {
                            setState(() {
                              _minRating = val;
                            });
                          },
                        ),
                        const SizedBox(height: 12.0),
                        HomeFilterSliderField(
                          title: 'Minimum Votes',
                          valueLabel: '$_minVotes votes',
                          value: _minVotes.toDouble(),
                          min: 0.0,
                          max: 500.0,
                          divisions: 50,
                          onChanged: (val) {
                            setState(() {
                              _minVotes = val.round();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
