import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_novel_observatory/vn/widgets/vndb_source_note.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../theme/app_theme.dart';
import 'settings_section_header.dart';
import 'vndb_profile_card.dart';
import 'vndb_connect_card.dart';
import 'settings_card.dart';
import 'theme_mode_tile.dart';
import 'true_black_tile.dart';
import 'theme_tile.dart';
import 'spoiler_tile.dart';
import 'explicit_content_tile.dart';
import 'violent_content_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDarkActive = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: context.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          children: [
            const SettingsSectionHeader(title: 'VNDB Profile'),
            const SizedBox(height: 12),
            if (authState.isAuthenticated)
              const VndbProfileCard()
            else
              const VndbConnectCard(),
            const SizedBox(height: 32),
            const SettingsSectionHeader(title: 'Appearance'),
            const SizedBox(height: 12),
            SettingsCard(
              children: [
                const ThemeModeTile(),
                if (isDarkActive) ...[
                  const Divider(height: 1),
                  const TrueBlackTile(),
                ],
                const Divider(height: 1),
                const ThemeTile(),
              ],
            ),
            const SizedBox(height: 32),
            const SettingsSectionHeader(title: 'Search Defaults'),
            const SizedBox(height: 12),
            const SettingsCard(
              children: [
                SpoilerTile(),
                Divider(height: 1),
                ExplicitContentTile(),
                Divider(height: 1),
                ViolentContentTile(),
              ],
            ),
            const SizedBox(height: 32),
            const Center(child: VndbSourceNote()),
          ],
        ),
      ),
    );
  }
}
