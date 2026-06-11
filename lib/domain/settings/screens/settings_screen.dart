import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final settingsState = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            _buildSectionHeader(theme, 'VNDB Profile'),
            const SizedBox(height: 12),
            if (authState.isAuthenticated)
              _buildProfileCard(context, ref, theme, authState)
            else
              _buildConnectCard(context, theme),
            const SizedBox(height: 32),
            _buildSectionHeader(theme, 'Search Defaults'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              theme,
              children: [
                _buildSpoilerTile(ref, settingsState),
                const Divider(color: Colors.white10, height: 1),
                _buildLanguageTile(ref, settingsState),
                const Divider(color: Colors.white10, height: 1),
                _buildPlatformTile(ref, settingsState),
                const Divider(color: Colors.white10, height: 1),
                _buildExplicitContentTile(ref, settingsState),
              ],
            ),
            const SizedBox(height: 32),
            _buildAppInfo(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: AppTheme.accentTeal,
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
        gradient: const LinearGradient(
          colors: [Color(0xFF2E3456), Color(0xFF232738)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppTheme.accentTeal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    auth.username?.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (auth.permissions.isNotEmpty) ...[
            Text(
              'Token Permissions:',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: auth.permissions.map((perm) {
                return Chip(
                  label: Text(
                    perm,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  backgroundColor: AppTheme.searchField,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
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
      color: AppTheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 48,
              color: AppTheme.textMuted,
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
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentTeal,
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

  Widget _buildSettingsCard(ThemeData theme, {required List<Widget> children}) {
    return Card(
      color: AppTheme.surface,
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _buildSpoilerTile(WidgetRef ref, SettingsState settings) {
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spoiler Filter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Default spoiler level for tags',
                  style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),
          DropdownButton<int>(
            value: settings.spoilerLevel,
            dropdownColor: AppTheme.surface,
            underline: const SizedBox(),
            items: spoilerLabels.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value, style: const TextStyle(fontSize: 14)),
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

  Widget _buildLanguageTile(WidgetRef ref, SettingsState settings) {
    final languageLabels = {
      null: 'Any Language',
      'en': 'English',
      'ja': 'Japanese',
      'zh': 'Chinese',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Preferred language in searches',
                  style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String?>(
            value: settings.defaultLanguage,
            dropdownColor: AppTheme.surface,
            underline: const SizedBox(),
            items: languageLabels.entries.map((entry) {
              return DropdownMenuItem<String?>(
                value: entry.key,
                child: Text(entry.value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (val) {
              ref.read(settingsProvider.notifier).setDefaultLanguage(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformTile(WidgetRef ref, SettingsState settings) {
    final platformLabels = {
      null: 'Any Platform',
      'win': 'Windows',
      'swi': 'Nintendo Switch',
      'ps4': 'PlayStation 4',
      'lin': 'Linux',
      'mac': 'macOS',
      'and': 'Android',
      'ios': 'iOS',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Platform',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Preferred platform filter',
                  style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),
          DropdownButton<String?>(
            value: settings.defaultPlatform,
            dropdownColor: AppTheme.surface,
            underline: const SizedBox(),
            items: platformLabels.entries.map((entry) {
              return DropdownMenuItem<String?>(
                value: entry.key,
                child: Text(entry.value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (val) {
              ref.read(settingsProvider.notifier).setDefaultPlatform(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExplicitContentTile(WidgetRef ref, SettingsState settings) {
    return SwitchListTile(
      value: settings.showExplicitContent,
      title: const Text(
        'Show Explicit Content',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: const Text(
        'Include 18+ sexual content in search results and uncover blurred images.',
        style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
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

  Widget _buildAppInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            'Observatory v1.0.0',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMuted,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Powered by VNDB API v2 (Kana)',
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
