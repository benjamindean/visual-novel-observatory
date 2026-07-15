import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/vn/models/visual_novel.dart';

void main() {
  group('VisualNovel', () {
    test('normalizes a VNDB image and rating response', () {
      final vn = VisualNovel.fromJson({
        'id': 'v17',
        'title': 'Ever17',
        'average': 82,
        'rating': 85,
        'image': {
          'url': 'https://example.test/cover.jpg',
          'dims': [600, 900],
          'sexual': 0.3,
          'violence': 0.4,
        },
      });

      expect(vn.average, 8.2);
      expect(vn.rating, 8.5);
      expect(vn.imageUrl, 'https://example.test/cover.jpg');
      expect(vn.imageDims, [600, 900]);
      expect(vn.imageSexual, 0.3);
      expect(vn.imageViolence, 0.4);
    });

    test('does not normalize locally serialized ratings a second time', () {
      final original = VisualNovel(
        id: 'v17',
        title: 'Ever17',
        rating: 8.5,
        imageUrl: 'https://example.test/cover.jpg',
      );

      final restored = VisualNovel.fromJson(original.toJson());

      expect(restored.rating, 8.5);
      expect(restored.imageUrl, original.imageUrl);
    });

    test('provides stable play length labels', () {
      expect(
        const VisualNovel(id: 'v1', title: 'A', length: 1).playLengthLabel,
        'Very Short (< 2 hours)',
      );
      expect(
        const VisualNovel(id: 'v1', title: 'A', length: 5).playLengthLabel,
        'Very Long (> 50 hours)',
      );
      expect(
        const VisualNovel(id: 'v1', title: 'A').playLengthLabel,
        'Unknown Length',
      );
    });

    test('extracts release year while preserving unknown values', () {
      expect(
        const VisualNovel(
          id: 'v1',
          title: 'A',
          released: '2026-07-15',
        ).releaseYear,
        '2026',
      );
      expect(
        const VisualNovel(id: 'v1', title: 'A', released: 'TBA').releaseYear,
        'TBA',
      );
      expect(
        const VisualNovel(id: 'v1', title: 'A', released: '???').releaseYear,
        '???',
      );
    });
  });
}
