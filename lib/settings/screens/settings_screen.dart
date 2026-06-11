import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final settingsState = ref.watch(settingsProvider);
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            _buildSectionHeader(context, 'VNDB Profile'),
            const SizedBox(height: 12),
            if (authState.isAuthenticated)
              _buildProfileCard(context, ref, theme, authState)
            else
              _buildConnectCard(context, theme),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Appearance'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildThemeModeTile(context, ref, settingsState),
                if (isDarkActive) ...[
                  const Divider(color: Colors.white10, height: 1),
                  _buildTrueBlackTile(context, ref, settingsState),
                ],
                const Divider(color: Colors.white10, height: 1),
                _buildThemeTile(context, ref, settingsState),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Search Defaults'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildSpoilerTile(context, ref, settingsState),
                const Divider(color: Colors.white10, height: 1),
                _buildExplicitContentTile(context, ref, settingsState),
              ],
            ),
            const SizedBox(height: 32),
            _buildAppInfo(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.appAccentTeal,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    AuthState auth,
  ) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary.withValues(alpha: 0.18),
            context.appSurface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.username ?? 'VNDB User',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'User ID: ${auth.userId}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: context.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text(
              'Disconnect Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectCard(BuildContext context, ThemeData theme) {
    return Card(
      color: context.appSurface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 48,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 12),
            Text(
              'Account Disconnected',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sync your list readings, statuses, and manage your VN library directly from Observatory.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.appTextMuted,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appAccentTeal,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text(
                'Connect VNDB Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Card(
      color: context.appSurface,
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _buildThemeModeTile(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    final modeLabels = {
      'system': 'Follow System',
      'light': 'Light',
      'dark': 'Dark',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Light, Dark, or System mode',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: settings.themeMode,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: modeLabels.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).setThemeMode(val);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrueBlackTile(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    return SwitchListTile(
      value: settings.darkIsTrueBlack,
      title: Text(
        'True Black Background',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appTextPrimary,
        ),
      ),
      subtitle: Text(
        'Pure black background for OLED screens',
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: (val) {
        ref.read(settingsProvider.notifier).setDarkIsTrueBlack(val);
      },
    );
  }

  Widget _buildThemeTile(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Choose color scheme',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: settings.themeName,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: AppTheme.themes.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).setThemeName(val);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpoilerTile(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    final spoilerLabels = {
      0: 'Hide Spoilers',
      1: 'Show Minor Spoilers',
      2: 'Show All Spoilers',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spoiler Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appTextPrimary,
                  ),
                ),
                Text(
                  'Default spoiler level for tags',
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
              ],
            ),
          ),
          DropdownButton<int>(
            value: settings.spoilerLevel,
            dropdownColor: context.appSurface,
            underline: const SizedBox(),
            alignment: Alignment.centerRight,
            items: spoilerLabels.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).setSpoilerLevel(val);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExplicitContentTile(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    return SwitchListTile(
      value: settings.showExplicitContent,
      title: const Text(
        'Show Explicit Content',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Include 18+ sexual content in search results and uncover blurred images.',
        style: TextStyle(fontSize: 12, color: context.appTextMuted),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onChanged: (val) {
        ref.read(settingsProvider.notifier).setShowExplicitContent(val);
      },
    );
  }

  Widget _buildAppInfo(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            'Observatory v1.0.0',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.appTextMuted,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Powered by VNDB API v2 (Kana)',
            style: theme.textTheme.labelSmall?.copyWith(
              color: context.appTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
