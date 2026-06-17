import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vn_tag.dart';
import '../../core/storage/app_storage.dart';

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
  final String? releasedFrom;
  final String? releasedTo;
  final List<VnTag> tags;

  const VnFilterState({
    this.lang = const [],
    this.platform = const [],
    this.length = const [],
    this.devStatus = const [],
    this.minRating = 7.0,
    this.minVotes = 50,
    this.releasedFrom,
    this.releasedTo,
    this.tags = const [],
  });

  VnFilterState copyWith({
    List<String>? lang,
    List<String>? platform,
    List<int>? length,
    List<int>? devStatus,
    double? minRating,
    int? minVotes,
    String? Function()? releasedFrom,
    String? Function()? releasedTo,
    List<VnTag>? tags,
  }) {
    return VnFilterState(
      lang: lang ?? this.lang,
      platform: platform ?? this.platform,
      length: length ?? this.length,
      devStatus: devStatus ?? this.devStatus,
      minRating: minRating ?? this.minRating,
      minVotes: minVotes ?? this.minVotes,
      releasedFrom: releasedFrom != null ? releasedFrom() : this.releasedFrom,
      releasedTo: releasedTo != null ? releasedTo() : this.releasedTo,
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
      releasedFrom == null &&
      releasedTo == null &&
      tags.isEmpty;

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
      'platform': platform,
      'length': length,
      'devStatus': devStatus,
      'minRating': minRating,
      'minVotes': minVotes,
      'releasedFrom': releasedFrom,
      'releasedTo': releasedTo,
      'tags': tags
          .map(
            (t) => t.toJson(),
          )
          .toList(),
    };
  }

  factory VnFilterState.fromJson(Map<String, dynamic> json) {
    return VnFilterState(
      lang: List<String>.from(json['lang'] ?? const []),
      platform: List<String>.from(json['platform'] ?? const []),
      length: List<int>.from(json['length'] ?? const []),
      devStatus: List<int>.from(json['devStatus'] ?? const []),
      minRating: (json['minRating'] as num?)?.toDouble() ?? 7.0,
      minVotes: json['minVotes'] as int? ?? 50,
      releasedFrom: json['releasedFrom'] as String?,
      releasedTo: json['releasedTo'] as String?,
      tags:
          (json['tags'] as List?)
              ?.map(
                (t) => VnTag.fromJson(
                  Map<String, dynamic>.from(t),
                ),
              )
              .toList() ??
          const [],
    );
  }

  List<dynamic> buildApiFilters() {
    final filters = <dynamic>[];

    if (lang.isNotEmpty) {
      if (lang.length == 1) {
        filters.add(
          [
            'lang',
            '=',
            lang.first,
          ],
        );
      } else {
        filters.add(
          [
            'or',
            ...lang.map(
              (l) => [
                'lang',
                '=',
                l,
              ],
            ),
          ],
        );
      }
    }

    if (platform.isNotEmpty) {
      if (platform.length == 1) {
        filters.add(
          [
            'platform',
            '=',
            platform.first,
          ],
        );
      } else {
        filters.add(
          [
            'or',
            ...platform.map(
              (p) => [
                'platform',
                '=',
                p,
              ],
            ),
          ],
        );
      }
    }

    if (length.isNotEmpty) {
      if (length.length == 1) {
        filters.add(
          [
            'length',
            '=',
            length.first,
          ],
        );
      } else {
        filters.add(
          [
            'or',
            ...length.map(
              (l) => [
                'length',
                '=',
                l,
              ],
            ),
          ],
        );
      }
    }

    if (devStatus.isNotEmpty) {
      if (devStatus.length == 1) {
        filters.add(
          [
            'devstatus',
            '=',
            devStatus.first,
          ],
        );
      } else {
        filters.add(
          [
            'or',
            ...devStatus.map(
              (d) => [
                'devstatus',
                '=',
                d,
              ],
            ),
          ],
        );
      }
    }

    if (minRating > 0.0) {
      filters.add(
        [
          'rating',
          '>=',
          (minRating * 10).round(),
        ],
      );
    }

    if (minVotes > 0) {
      filters.add(
        [
          'votecount',
          '>=',
          minVotes,
        ],
      );
    }

    if (releasedFrom != null) {
      filters.add(
        [
          'released',
          '>=',
          releasedFrom!,
        ],
      );
    }

    if (releasedTo != null) {
      filters.add(
        [
          'released',
          '<=',
          releasedTo!,
        ],
      );
    }

    for (final tag in tags) {
      filters.add(
        [
          'tag',
          '=',
          tag.id,
        ],
      );
    }

    return filters;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VnFilterState &&
        listEquals(other.lang, lang) &&
        listEquals(other.platform, platform) &&
        listEquals(other.length, length) &&
        listEquals(other.devStatus, devStatus) &&
        other.minRating == minRating &&
        other.minVotes == minVotes &&
        other.releasedFrom == releasedFrom &&
        other.releasedTo == releasedTo &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return Object.hash(
      Object.hashAll(lang),
      Object.hashAll(platform),
      Object.hashAll(length),
      Object.hashAll(devStatus),
      minRating,
      minVotes,
      releasedFrom,
      releasedTo,
      Object.hashAll(tags),
    );
  }
}

class VnFilterNotifier extends Notifier<VnFilterState> {
  static const String _filterKey = 'user_vn_filters';

  @override
  VnFilterState build() {
    final box = AppStorage.mainBox;
    final savedFilterMap = box.get(_filterKey);

    if (savedFilterMap != null) {
      try {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          savedFilterMap as Map,
        );

        return VnFilterState.fromJson(json);
      } catch (e) {
        // Fallback on error
      }
    }

    return VnFilterState();
  }

  Future<void> update(VnFilterState value) async {
    state = value;
    final box = AppStorage.mainBox;

    await box.put(_filterKey, value.toJson());
  }
}

final vnFilterProvider = NotifierProvider<VnFilterNotifier, VnFilterState>(
  VnFilterNotifier.new,
);

final hasActiveHomeFiltersProvider = Provider<bool>((ref) {
  final filters = ref.watch(vnFilterProvider);

  return filters.lang.isNotEmpty ||
      filters.platform.isNotEmpty ||
      filters.length.isNotEmpty ||
      filters.devStatus.isNotEmpty ||
      filters.minRating != 7.0 ||
      filters.minVotes != 50 ||
      filters.releasedFrom != null ||
      filters.releasedTo != null ||
      filters.tags.isNotEmpty;
});

class VnSortState {
  final String field;
  final bool descending;

  const VnSortState({
    required this.field,
    this.descending = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'descending': descending,
    };
  }

  factory VnSortState.fromJson(Map<String, dynamic> json) {
    return VnSortState(
      field: json['field'] as String? ?? 'rating',
      descending: json['descending'] as bool? ?? true,
    );
  }

  VnSortState copyWith({
    String? field,
    bool? descending,
  }) {
    return VnSortState(
      field: field ?? this.field,
      descending: descending ?? this.descending,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VnSortState &&
        other.field == field &&
        other.descending == descending;
  }

  @override
  int get hashCode => Object.hash(field, descending);
}

class VnSortNotifier extends Notifier<VnSortState> {
  static const String _sortKey = 'user_vn_sort';

  @override
  VnSortState build() {
    final box = AppStorage.mainBox;
    final savedSortMap = box.get(_sortKey);

    if (savedSortMap != null) {
      try {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          savedSortMap as Map,
        );

        return VnSortState.fromJson(json);
      } catch (e) {
        // Fallback on error
      }
    }

    return const VnSortState(
      field: 'rating',
      descending: true,
    );
  }

  Future<void> _saveSort(VnSortState sortState) async {
    final box = AppStorage.mainBox;

    await box.put(_sortKey, sortState.toJson());
  }

  void updateField(String field) {
    final bool defaultDesc = field != 'title' && field != 'id';

    state = VnSortState(
      field: field,
      descending: defaultDesc,
    );
    _saveSort(state);
  }

  void toggleDirection() {
    state = state.copyWith(
      descending: !state.descending,
    );
    _saveSort(state);
  }

  void updateSort({
    required String field,
    required bool descending,
  }) {
    state = VnSortState(
      field: field,
      descending: descending,
    );
    _saveSort(state);
  }
}

final vnSortProvider = NotifierProvider<VnSortNotifier, VnSortState>(
  VnSortNotifier.new,
);
