import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../../vn/providers/vn_ulist_providers.dart';

class AppStartupSyncListener extends ConsumerStatefulWidget {
  const AppStartupSyncListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<AppStartupSyncListener> createState() {
    return AppStartupSyncListenerState();
  }
}

class AppStartupSyncListenerState
    extends ConsumerState<AppStartupSyncListener> {
  String? _syncedUserId;

  @override
  void initState() {
    super.initState();

    ref.listenManual<UserUlistState>(
      userUlistProvider,
      (_, _) {},
      fireImmediately: false,
    );

    ref.listenManual<AsyncValue<AuthState>>(
      authProvider,
      _handleAuthChanged,
      fireImmediately: true,
    );
  }

  Future<void> _handleAuthChanged(
    AsyncValue<AuthState>? previous,
    AsyncValue<AuthState> next,
  ) async {
    final auth = next.value;
    final previousAuth = previous?.value;
    final userId = auth?.userId;

    if (auth?.isAuthenticated != true || userId == null) {
      _syncedUserId = null;

      if (previousAuth?.isAuthenticated == true) {
        ref.read(userUlistProvider.notifier).clearLocalState();
        ref.invalidate(ulistLabelsProvider);
      }

      return;
    }

    if (_syncedUserId == userId) {
      return;
    }

    _syncedUserId = userId;

    try {
      await ref
          .read(userUlistProvider.notifier)
          .syncUserListAndData(showLoading: false);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to sync VNDB library during app startup.',
        name: 'AppStartupSyncListener',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
