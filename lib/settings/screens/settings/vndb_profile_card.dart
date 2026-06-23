import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../../theme/app_theme.dart';
import '../../../vn/providers/vn_providers.dart';
import '../../../core/utils/error_utils.dart';

class VndbProfileCard extends ConsumerWidget {
  const VndbProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(
      authProvider.select(
        (state) => (
          username: state.value?.username,
          userId: state.value?.userId,
        ),
      ),
    );
    final isUserListLoading = ref.watch(
      userUlistProvider.select((state) => state.isLoading),
    );
    final areTagsLoading = ref.watch(
      localTagsProvider.select((state) => state.isLoading),
    );
    final theme = Theme.of(context);
    final isSyncing = isUserListLoading || areTagsLoading;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colorScheme.primaryContainer, context.appSurface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appAccentTeal,
                    foregroundColor: context.colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: isSyncing
                      ? null
                      : () async {
                          try {
                            await ref
                                .read(userUlistProvider.notifier)
                                .syncUserListAndData();

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data synced successfully!'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to sync: ${cleanErrorMessage(e)}',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                  icon: isSyncing
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colorScheme.inverseSurface,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.sync_rounded,
                          size: 18,
                          color: context.colorScheme.onPrimary,
                        ),
                  label: const Text(
                    'Sync Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.error,
                    foregroundColor: context.colorScheme.onError,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    _showDisconnectConfirmation(context, ref);
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 18,
                    color: context.colorScheme.onPrimary,
                  ),
                  label: const Text(
                    'Disconnect',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDisconnectConfirmation(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final isConfirmed = await showAppConfirmationDialog(
      context: context,
      title: 'Disconnect Account',
      message:
          'Are you sure you want to disconnect your VNDB account? Your local data sync will be disabled.',
      confirmLabel: 'Disconnect',
    );

    if (!isConfirmed || !context.mounted) {
      return;
    }

    await ref.read(authProvider.notifier).disconnect();
  }
}
