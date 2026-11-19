import 'package:material_ui/material_ui.dart';
import 'package:visual_novel_observatory/settings/providers/settings_provider.dart';

Widget testMaterialApp(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

class TestSettingsNotifier extends SettingsNotifier {
  TestSettingsNotifier(this.initialState);

  final SettingsState initialState;

  @override
  SettingsState build() => initialState;
}
