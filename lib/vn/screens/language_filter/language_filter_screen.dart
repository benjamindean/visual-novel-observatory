import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../constants/vndb_languages.dart';
import '../../widgets/app_search_input.dart';
import '../../widgets/bottom_action_bar.dart';
import 'widgets/language_filter_empty_state.dart';
import 'widgets/language_filter_list_tile.dart';

class LanguageFilterScreen extends StatefulWidget {
  const LanguageFilterScreen({
    super.key,
    required this.initialLanguageIds,
  });

  final List<String> initialLanguageIds;

  @override
  State<LanguageFilterScreen> createState() => LanguageFilterScreenState();
}

class LanguageFilterScreenState extends State<LanguageFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedLanguageIds = {};

  String _query = '';

  @override
  void initState() {
    super.initState();

    _selectedLanguageIds.addAll(widget.initialLanguageIds);
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

  void _toggleLanguage(VndbLanguage language) {
    setState(() {
      if (!_selectedLanguageIds.remove(language.id)) {
        _selectedLanguageIds.add(language.id);
      }
    });
  }

  List<String> _orderedSelection() {
    return vndbLanguages
        .where((language) => _selectedLanguageIds.contains(language.id))
        .map((language) => language.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayLanguages = _query.isEmpty
        ? vndbLanguages
        : vndbLanguages.where((language) {
            return language.id.toLowerCase().contains(_query) ||
                language.label.toLowerCase().contains(_query);
          }).toList();
    final orderedLanguages = [
      ...displayLanguages.where(
        (language) => _selectedLanguageIds.contains(language.id),
      ),
      ...displayLanguages.where(
        (language) => !_selectedLanguageIds.contains(language.id),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter by Languages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: _selectedLanguageIds.isEmpty
                ? null
                : () {
                    setState(_selectedLanguageIds.clear);
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
        label: 'Save Languages',
        onPressed: () {
          Navigator.of(context).pop(_orderedSelection());
        },
      ),
      body: Stack(
        children: [
          displayLanguages.isEmpty
              ? LanguageFilterEmptyState(query: _searchController.text)
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    8.0,
                    16.0,
                    74.0,
                  ),
                  itemCount: orderedLanguages.length,
                  itemBuilder: (context, index) {
                    final language = orderedLanguages[index];

                    return LanguageFilterListTile(
                      language: language,
                      isSelected: _selectedLanguageIds.contains(language.id),
                      onTap: () => _toggleLanguage(language),
                    );
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: AppSearchInput(
                controller: _searchController,
                onChanged: _setQuery,
                hintText: 'Search languages...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
