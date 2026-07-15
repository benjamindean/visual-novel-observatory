import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/settings/providers/settings_provider.dart';
import 'package:visual_novel_observatory/vn/utils/vndb_content_sensitivity.dart';
import 'package:visual_novel_observatory/vn/widgets/app_search_input.dart';
import 'package:visual_novel_observatory/vn/widgets/bottom_action_bar.dart';
import 'package:visual_novel_observatory/vn/widgets/chip_overflow_wrap.dart';
import 'package:visual_novel_observatory/vn/widgets/reveal_image_button.dart';
import 'package:visual_novel_observatory/vn/widgets/spoiler_text.dart';

import '../../helpers/test_harness.dart';

void main() {
  group('AppSearchInput', () {
    testWidgets('clear action empties the controller and reports the change', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'Ever17');
      final changes = <String>[];
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        testMaterialApp(
          AppSearchInput(
            controller: controller,
            onChanged: changes.add,
            hintText: 'Search...',
          ),
        ),
      );

      expect(find.byIcon(Icons.clear_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.clear_rounded));
      await tester.pump();

      expect(controller.text, isEmpty);
      expect(changes, ['']);
      expect(find.byIcon(Icons.clear_rounded), findsNothing);
    });

    testWidgets('moves its listener when the controller changes', (
      tester,
    ) async {
      final firstController = TextEditingController(text: 'first');
      final secondController = TextEditingController();
      var activeController = firstController;
      late StateSetter rebuild;
      addTearDown(firstController.dispose);
      addTearDown(secondController.dispose);

      await tester.pumpWidget(
        testMaterialApp(
          StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;

              return AppSearchInput(
                controller: activeController,
                onChanged: (_) {},
                hintText: 'Search...',
              );
            },
          ),
        ),
      );

      expect(find.byIcon(Icons.clear_rounded), findsOneWidget);
      rebuild(() {
        activeController = secondController;
      });
      await tester.pump();
      expect(find.byIcon(Icons.clear_rounded), findsNothing);

      secondController.text = 'second';
      await tester.pump();
      expect(find.byIcon(Icons.clear_rounded), findsOneWidget);
    });
  });

  group('ChipOverflowWrap', () {
    testWidgets('expands and collapses hidden chips', (tester) async {
      await tester.pumpWidget(
        testMaterialApp(
          ChipOverflowWrap(
            initialLimit: 2,
            children: const [
              Text('One'),
              Text('Two'),
              Text('Three'),
              Text('Four'),
            ],
          ),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
      expect(find.text('Three'), findsNothing);
      expect(find.text('2 more'), findsOneWidget);

      await tester.tap(find.text('2 more'));
      await tester.pump();
      expect(find.text('Three'), findsOneWidget);
      expect(find.text('Four'), findsOneWidget);
      expect(find.text('Show less'), findsOneWidget);

      await tester.tap(find.text('Show less'));
      await tester.pump();
      expect(find.text('Three'), findsNothing);
    });
  });

  group('SpoilerText', () {
    testWidgets('strips supported BBCode from normal text', (tester) async {
      await tester.pumpWidget(
        testMaterialApp(
          const SpoilerText(
            text: '[b]Bold[/b] and [url=https://example.test]linked[/url]',
          ),
        ),
      );

      expect(find.text('Bold and linked'), findsOneWidget);
      expect(find.textContaining('[b]'), findsNothing);
    });

    testWidgets('reveals each spoiler independently', (tester) async {
      await tester.pumpWidget(
        testMaterialApp(
          const SpoilerText(
            text: 'A [spoiler]first[/spoiler] B [spoiler]second[/spoiler]',
          ),
        ),
      );

      expect(find.text('Spoiler (Tap to reveal)'), findsNWidgets(2));
      await tester.tap(find.text('Spoiler (Tap to reveal)').first);
      await tester.pump();

      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsNothing);
      expect(find.text('Spoiler (Tap to reveal)'), findsOneWidget);
    });
  });

  group('RevealImageButton', () {
    testWidgets('is unavailable while strict safe mode is enabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWith(
              () => TestSettingsNotifier(SettingsState()),
            ),
          ],
          child: testMaterialApp(
            RevealImageButton(
              onPressed: () {},
              reasons: const [VndbContentSensitivityReason.sexual],
            ),
          ),
        ),
      );

      expect(find.text('Reveal Image'), findsNothing);
      expect(find.text('Image Hidden'), findsNothing);
    });

    testWidgets('shows reasons and invokes reveal outside strict safe mode', (
      tester,
    ) async {
      var wasPressed = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWith(
              () => TestSettingsNotifier(
                SettingsState(disableExplicitContent: false),
              ),
            ),
          ],
          child: testMaterialApp(
            RevealImageButton(
              onPressed: () {
                wasPressed = true;
              },
              reasons: const [
                VndbContentSensitivityReason.spoiler,
                VndbContentSensitivityReason.sexual,
                VndbContentSensitivityReason.violent,
              ],
            ),
          ),
        ),
      );

      expect(find.text('Image Hidden'), findsOneWidget);
      expect(
        find.text('Spoiler content, Sexual content, and Violent content'),
        findsOneWidget,
      );
      await tester.tap(find.text('Reveal Image'));
      expect(wasPressed, isTrue);
    });
  });

  group('BottomActionBar', () {
    testWidgets('shows an optional icon and non-zero badge', (tester) async {
      await tester.pumpWidget(
        testMaterialApp(
          BottomActionBar(
            label: 'Save',
            icon: Icons.save,
            badgeCount: 3,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('disables its action when callback is null', (tester) async {
      await tester.pumpWidget(
        testMaterialApp(
          const BottomActionBar(
            label: 'Save',
            badgeCount: 0,
            onPressed: null,
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(button.onPressed, isNull);
      expect(find.text('0'), findsNothing);
    });
  });
}
