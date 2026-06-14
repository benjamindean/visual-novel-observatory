import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vn_tag.dart';
import '../../settings/providers/settings_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

class VnFilterState {
  final List<String> lang;
  final List<String> platform;
  final List<int> length;
  final List<int> devStatus;
  final double minRating; // 0.0 to 10.0
  final int minVotes;
  final bool showExplicitContent;
  final List<VnTag> tags;

  VnFilterState({
    this.lang = const [],
    this.platform = const [],
    this.length = const [],
    this.devStatus = const [],
    this.minRating = 7.0,
    this.minVotes = 50,
    this.showExplicitContent = false,
    this.tags = const [],
  });

  VnFilterState copyWith({
    List<String>? lang,
    List<String>? platform,
    List<int>? length,
    List<int>? devStatus,
    double? minRating,
    int? minVotes,
    bool? showExplicitContent,
    List<VnTag>? tags,
  }) {
    return VnFilterState(
      lang: lang ?? this.lang,
      platform: platform ?? this.platform,
      length: length ?? this.length,
      devStatus: devStatus ?? this.devStatus,
      minRating: minRating ?? this.minRating,
      minVotes: minVotes ?? this.minVotes,
      showExplicitContent: showExplicitContent ?? this.showExplicitContent,
      tags: tags ?? this.tags,
    );
  }

  bool get isEmpty =>
      lang.isEmpty &&
      platform.isEmpty &&
      length.isEmpty &&
      devStatus.isEmpty &&
      minRating == 7.0 &&
      minVotes == 50 &&
      !showExplicitContent &&
      tags.isEmpty;

  List<dynamic> buildApiFilters() {
    final filters = <dynamic>[];

    if (lang.isNotEmpty) {
      if (lang.length == 1) {
        filters.add(['lang', '=', lang.first]);
      } else {
        filters.add([
          'or',
          ...lang.map((l) => ['lang', '=', l]),
        ]);
      }
    }

    if (platform.isNotEmpty) {
      if (platform.length == 1) {
        filters.add(['platform', '=', platform.first]);
      } else {
        filters.add([
          'or',
          ...platform.map((p) => ['platform', '=', p]),
        ]);
      }
    }

    if (length.isNotEmpty) {
      if (length.length == 1) {
        filters.add(['length', '=', length.first]);
      } else {
        filters.add([
          'or',
          ...length.map((l) => ['length', '=', l]),
        ]);
      }
    }

    if (devStatus.isNotEmpty) {
      if (devStatus.length == 1) {
        filters.add(['devstatus', '=', devStatus.first]);
      } else {
        filters.add([
          'or',
          ...devStatus.map((d) => ['devstatus', '=', d]),
        ]);
      }
    }

    // Always apply rating and votecount if set (or let it be dynamic)
    filters.add(['rating', '>=', (minRating * 10).round()]);
    filters.add(['votecount', '>=', minVotes]);

    for (final tag in tags) {
      filters.add(['tag', '=', tag.id]);
    }

    return filters;
  }
}

class VnFilterNotifier extends Notifier<VnFilterState> {
  @override
  VnFilterState build() {
    final settings = ref.watch(settingsProvider);

    return VnFilterState(
      lang: settings.defaultLanguage != null
          ? [settings.defaultLanguage!]
          : const [],
      platform: settings.defaultPlatform != null
          ? [settings.defaultPlatform!]
          : const [],
      showExplicitContent: settings.showExplicitContent,
    );
  }

  void update(VnFilterState value) => state = value;
}

final vnFilterProvider = NotifierProvider<VnFilterNotifier, VnFilterState>(
  VnFilterNotifier.new,
);

class VnSortState {
  final String field;
  final bool descending;

  const VnSortState({required this.field, this.descending = true});

  VnSortState copyWith({String? field, bool? descending}) {
    return VnSortState(
      field: field ?? this.field,
      descending: descending ?? this.descending,
    );
  }
}

class VnSortNotifier extends Notifier<VnSortState> {
  @override
  VnSortState build() {
    return const VnSortState(field: 'rating', descending: true);
  }

  void updateField(String field) {
    final bool defaultDesc = field != 'title' && field != 'id';

    state = VnSortState(field: field, descending: defaultDesc);
  }

  void toggleDirection() {
    state = state.copyWith(descending: !state.descending);
  }

  void updateSort({required String field, required bool descending}) {
    state = VnSortState(field: field, descending: descending);
  }
}

final vnSortProvider = NotifierProvider<VnSortNotifier, VnSortState>(
  VnSortNotifier.new,
);
