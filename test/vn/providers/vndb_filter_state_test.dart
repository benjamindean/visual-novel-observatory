import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/vn/models/vn_tag.dart';
import 'package:visual_novel_observatory/vn/providers/vn_filter_providers.dart';

void main() {
  group('VnFilterState', () {
    test('defaults match the app default and are considered empty', () {
      const state = VnFilterState();

      expect(state.isEmpty, isTrue);
      expect(state.minRating, 7);
      expect(state.minVotes, 50);
    });

    test('builds single-value predicates and default quality thresholds', () {
      const state = VnFilterState(
        lang: ['en'],
        platform: ['win'],
        length: [3],
        devStatus: [0],
      );

      expect(
        state.buildApiFilters(),
        [
          ['lang', '=', 'en'],
          ['platform', '=', 'win'],
          ['length', '=', 3],
          ['devstatus', '=', 0],
          ['rating', '>=', 70],
          ['votecount', '>=', 50],
        ],
      );
    });

    test('uses or groups for multi-value fields', () {
      const state = VnFilterState(
        lang: ['en', 'ja'],
        platform: ['win', 'swi'],
        minRating: 0,
        minVotes: 0,
      );

      expect(
        state.buildApiFilters(),
        [
          [
            'or',
            ['lang', '=', 'en'],
            ['lang', '=', 'ja'],
          ],
          [
            'or',
            ['platform', '=', 'win'],
            ['platform', '=', 'swi'],
          ],
        ],
      );
    });

    test('builds date and tag predicates and clamps spoiler level', () {
      const tag = VnTag(id: 'g505', name: 'Mystery');
      const state = VnFilterState(
        minRating: 8.25,
        minVotes: 100,
        releasedFrom: '2020-01-01',
        releasedTo: '2025-12-31',
        tags: [tag],
      );

      expect(
        state.buildApiFilters(spoilerLevel: 99),
        containsAll([
          ['rating', '>=', 83],
          ['votecount', '>=', 100],
          ['released', '>=', '2020-01-01'],
          ['released', '<=', '2025-12-31'],
          [
            'tag',
            '=',
            ['g505', 2, 0],
          ],
        ]),
      );
      expect(
        state.buildApiFilters(spoilerLevel: -1).last,
        [
          'tag',
          '=',
          ['g505', 0, 0],
        ],
      );
    });

    test('round-trips through JSON without losing fields', () {
      const original = VnFilterState(
        lang: ['en'],
        platform: ['win'],
        length: [4],
        devStatus: [1],
        minRating: 9,
        minVotes: 500,
        releasedFrom: '2024',
        releasedTo: '2026',
        tags: [VnTag(id: 'g505', name: 'Mystery', category: 'cont')],
      );

      expect(VnFilterState.fromJson(original.toJson()), original);
    });

    test('copyWith can explicitly clear nullable dates', () {
      const original = VnFilterState(
        releasedFrom: '2020',
        releasedTo: '2025',
      );

      final cleared = original.copyWith(
        releasedFrom: () => null,
        releasedTo: () => null,
      );

      expect(cleared.releasedFrom, isNull);
      expect(cleared.releasedTo, isNull);
    });
  });

  group('VnSortState', () {
    test('round-trips through JSON and supports immutable updates', () {
      const original = VnSortState(field: 'title', descending: false);

      expect(VnSortState.fromJson(original.toJson()), original);
      expect(original.copyWith(descending: true).descending, isTrue);
      expect(original.descending, isFalse);
    });

    test('uses safe defaults for incomplete stored data', () {
      final state = VnSortState.fromJson(const {});

      expect(state, const VnSortState(field: 'rating', descending: true));
    });
  });
}
