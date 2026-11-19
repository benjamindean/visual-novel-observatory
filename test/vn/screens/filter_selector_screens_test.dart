import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/vn/screens/language_filter/language_filter_screen.dart';
import 'package:visual_novel_observatory/vn/screens/platform_filter/platform_filter_screen.dart';
import 'package:visual_novel_observatory/vn/widgets/filter_selectable_list_tile.dart';

void main() {
  testWidgets('language selector searches, selects, and returns language IDs', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: _LanguageSelectorHost()));

    await tester.tap(find.text('Open languages'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Japanese');
    await tester.pump();

    final japaneseTile = find.widgetWithText(
      FilterSelectableListTile,
      'Japanese',
    );

    expect(japaneseTile, findsOneWidget);
    expect(find.text('English'), findsNothing);
    await tester.tap(japaneseTile);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Save Languages'));
    await tester.pumpAndSettle();
    expect(find.text('Languages: ja'), findsOneWidget);
  });

  testWidgets(
    'language selector puts initial selections first and clears them',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LanguageFilterScreen(initialLanguageIds: ['en']),
        ),
      );

      final englishTop = tester.getTopLeft(find.text('English')).dy;
      final arabicTop = tester.getTopLeft(find.text('Arabic')).dy;

      expect(englishTop, lessThan(arabicTop));
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.text('Clear'));
      await tester.pump();
      expect(find.text('1'), findsNothing);
    },
  );

  testWidgets('platform selector searches, selects, and returns platform IDs', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: _PlatformSelectorHost()));

    await tester.tap(find.text('Open platforms'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Android');
    await tester.pump();

    final androidTile = find.widgetWithText(
      FilterSelectableListTile,
      'Android',
    );

    expect(androidTile, findsOneWidget);
    expect(find.text('Windows'), findsNothing);
    await tester.tap(androidTile);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Save Platforms'));
    await tester.pumpAndSettle();
    expect(find.text('Platforms: and'), findsOneWidget);
  });
}

class _LanguageSelectorHost extends StatefulWidget {
  const _LanguageSelectorHost();

  @override
  State<_LanguageSelectorHost> createState() => _LanguageSelectorHostState();
}

class _LanguageSelectorHostState extends State<_LanguageSelectorHost> {
  List<String>? _selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Languages: ${_selection?.join(',') ?? 'none'}'),
            ElevatedButton(
              onPressed: () async {
                final selection = await Navigator.of(context)
                    .push<List<String>>(
                      MaterialPageRoute(
                        builder: (context) => const LanguageFilterScreen(
                          initialLanguageIds: [],
                        ),
                      ),
                    );

                if (selection != null && mounted) {
                  setState(() {
                    _selection = selection;
                  });
                }
              },
              child: const Text('Open languages'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlatformSelectorHost extends StatefulWidget {
  const _PlatformSelectorHost();

  @override
  State<_PlatformSelectorHost> createState() => _PlatformSelectorHostState();
}

class _PlatformSelectorHostState extends State<_PlatformSelectorHost> {
  List<String>? _selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Platforms: ${_selection?.join(',') ?? 'none'}'),
            ElevatedButton(
              onPressed: () async {
                final selection = await Navigator.of(context)
                    .push<List<String>>(
                      MaterialPageRoute(
                        builder: (context) => const PlatformFilterScreen(
                          initialPlatformIds: [],
                        ),
                      ),
                    );

                if (selection != null && mounted) {
                  setState(() {
                    _selection = selection;
                  });
                }
              },
              child: const Text('Open platforms'),
            ),
          ],
        ),
      ),
    );
  }
}
