import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/vn/models/visual_novel.dart';
import 'package:visual_novel_observatory/vn/models/vn_ulist_entry.dart';
import 'package:visual_novel_observatory/vn/models/vndb_label.dart';
import 'package:visual_novel_observatory/vn/providers/vn_ulist_providers.dart';
import 'package:visual_novel_observatory/vn/screens/library/widgets/library_label_utils.dart';

void main() {
  group('VnUlistEntry', () {
    test('normalizes nested labels and removes the VNDB voted label', () {
      final entry = VnUlistEntry.fromJson({
        'id': 'v17',
        'labels': [
          {'id': 1},
          {'id': 7},
          3,
        ],
        'vn': {'title': 'Ever17'},
      });

      expect(entry.labels, [1, 3]);
      expect(entry.vn?.id, 'v17');
      expect(entry.vn?.title, 'Ever17');
    });
  });

  group('library label filtering', () {
    test('removes system, empty, and duplicate-purpose labels', () {
      const labels = [
        VndbLabel(id: 0, label: 'No label'),
        VndbLabel(id: 1, label: 'Playing'),
        VndbLabel(id: 2, label: ''),
        VndbLabel(id: 3),
        VndbLabel(id: 7, label: 'Voted'),
        VndbLabel(id: 8, label: 'NO LABEL'),
        VndbLabel(id: 9, label: 'Finished'),
      ];

      expect(
        filterVisibleLibraryLabels(labels),
        const [
          VndbLabel(id: 1, label: 'Playing'),
          VndbLabel(id: 9, label: 'Finished'),
        ],
      );
    });
  });

  group('library providers', () {
    late ProviderContainer container;

    tearDown(() {
      container.dispose();
    });

    test(
      'filters by label, skips missing VN data, and sorts newest first',
      () async {
        final state = UserUlistState(
          entries: {
            'v1': const VnUlistEntry(
              id: 'v1',
              added: 100,
              labels: [1],
              vn: VisualNovel(id: 'v1', title: 'Older'),
            ),
            'v2': const VnUlistEntry(
              id: 'v2',
              added: 300,
              labels: [1, 2],
              vn: VisualNovel(id: 'v2', title: 'Newest'),
            ),
            'v3': const VnUlistEntry(
              id: 'v3',
              added: 400,
              labels: [1],
            ),
            'v4': const VnUlistEntry(
              id: 'v4',
              added: 500,
              labels: [2],
              vn: VisualNovel(id: 'v4', title: 'Different label'),
            ),
          },
        );
        container = ProviderContainer(
          overrides: [
            userUlistProvider.overrideWith(
              () => TestUserUlistNotifier(state),
            ),
          ],
        );

        await container.read(userUlistProvider.future);
        final visualNovels = container.read(libraryVnsByLabelProvider(1));

        expect(
          visualNovels.map((vn) => vn.title),
          ['Newest', 'Older'],
        );
        expect(container.read(libraryVnCountByLabelProvider(1)), 2);
      },
    );

    test('exposes per-VN entry state', () async {
      const entry = VnUlistEntry(
        id: 'v17',
        labels: [1],
        vn: VisualNovel(id: 'v17', title: 'Ever17'),
      );
      container = ProviderContainer(
        overrides: [
          userUlistProvider.overrideWith(
            () => TestUserUlistNotifier(
              const UserUlistState(entries: {'v17': entry}),
            ),
          ),
        ],
      );

      await container.read(userUlistProvider.future);
      final state = container.read(vnUlistProvider('v17'));

      expect(state.entry, entry);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
    });
  });
}

class TestUserUlistNotifier extends UserUlistNotifier {
  TestUserUlistNotifier(this.initialState);

  final UserUlistState initialState;

  @override
  Future<UserUlistState> build() async => initialState;
}
