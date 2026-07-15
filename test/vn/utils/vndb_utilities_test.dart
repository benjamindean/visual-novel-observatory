import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/vn/utils/vndb_content_sensitivity.dart';
import 'package:visual_novel_observatory/vn/utils/vndb_date_display.dart';
import 'package:visual_novel_observatory/vn/utils/vndb_safe_content_filter.dart';

void main() {
  group('VNDB content sensitivity', () {
    test('uses a strict greater-than threshold', () {
      expect(
        isSensitiveVndbContent(
          sexual: vndbContentSensitivityThreshold,
          violence: null,
          blurSexualContent: true,
          blurViolentContent: true,
        ),
        isFalse,
      );
      expect(
        isSensitiveVndbContent(
          sexual: vndbContentSensitivityThreshold + 0.01,
          violence: null,
          blurSexualContent: true,
          blurViolentContent: true,
        ),
        isTrue,
      );
    });

    test('only reports enabled sensitivity categories', () {
      expect(
        vndbContentSensitivityReasons(
          sexual: 1,
          violence: 1,
          blurSexualContent: false,
          blurViolentContent: true,
        ),
        [VndbContentSensitivityReason.violent],
      );
    });

    test('keeps reason ordering stable for user-facing text', () {
      expect(
        vndbContentSensitivityReasons(
          sexual: 1,
          violence: 1,
          blurSexualContent: true,
          blurViolentContent: true,
          hasSpoiler: true,
        ),
        [
          VndbContentSensitivityReason.spoiler,
          VndbContentSensitivityReason.sexual,
          VndbContentSensitivityReason.violent,
        ],
      );
    });

    test('revealed sensitive content is no longer blurred', () {
      expect(
        shouldBlurVndbContent(
          sexual: 0.8,
          violence: 0,
          blurSexualContent: true,
          blurViolentContent: false,
        ),
        isTrue,
      );
      expect(
        shouldBlurVndbContent(
          sexual: 0.8,
          violence: 0,
          blurSexualContent: true,
          blurViolentContent: false,
          isRevealed: true,
        ),
        isFalse,
      );
    });
  });

  group('VNDB safe content filters', () {
    test('leaves an empty filter empty when safe mode is disabled', () {
      expect(
        applyVndbSafeContentFilters(
          filters: const [],
          disableExplicitContent: false,
        ),
        isEmpty,
      );
    });

    test('preserves a caller filter when safe mode is disabled', () {
      final result = applyVndbSafeContentFilters(
        filters: const ['search', '=', 'Steins;Gate'],
        disableExplicitContent: false,
      );

      expect(result, ['search', '=', 'Steins;Gate']);
    });

    test('requires no-sexual-content and excludes blocked tags', () {
      final filters = vndbSafeContentFilters();

      expect(
        filters,
        contains(
          equals([
            'tag',
            '=',
            [
              vndbNoSexualContentTagId,
              vndbContentSafetyTagSpoilerLevel,
              vndbContentSafetyMinTagLevel,
            ],
          ]),
        ),
      );
      expect(
        filters,
        contains(
          equals([
            'tag',
            '!=',
            [
              vndbViolenceTagId,
              vndbContentSafetyTagSpoilerLevel,
              vndbContentSafetyMinTagLevel,
            ],
          ]),
        ),
      );
      expect(filters, hasLength(11));
    });

    test('combines the caller filter and every safety predicate with and', () {
      final result = applyVndbSafeContentFilters(
        filters: const ['id', '=', 'v17'],
        disableExplicitContent: true,
      );

      expect(result.first, 'and');
      expect(result[1], ['id', '=', 'v17']);
      expect(result, hasLength(vndbSafeContentFilters().length + 2));
    });
  });

  group('formatVndbDate', () {
    test('formats unknown, year, month, and full date precision', () {
      expect(formatVndbDate(null), 'TBA');
      expect(formatVndbDate(''), 'TBA');
      expect(formatVndbDate('2026'), '2026');
      expect(formatVndbDate('2026-07'), 'Jul 2026');
      expect(formatVndbDate('2026-07-15'), '15 Jul 2026');
    });

    test('accepts valid leap days', () {
      expect(formatVndbDate('2024-02-29'), '29 Feb 2024');
    });

    test('returns malformed or impossible dates unchanged', () {
      expect(formatVndbDate('unknown'), 'unknown');
      expect(formatVndbDate('2026-13'), '2026-13');
      expect(formatVndbDate('2026-02-29'), '2026-02-29');
      expect(formatVndbDate('2026-04-31'), '2026-04-31');
    });
  });
}
