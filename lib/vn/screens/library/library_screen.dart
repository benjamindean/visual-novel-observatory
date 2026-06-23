import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/providers/auth_provider.dart';
import 'library_auth_placeholder.dart';
import 'widgets/library_content.dart';
import 'widgets/library_loading_view.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);

    return authAsync.when(
      data: (auth) {
        if (!auth.isAuthenticated) {
          return const LibraryAuthPlaceholder();
        }

        return const LibraryContent();
      },
      loading: () => const LibraryLoadingView(),
      error: (error, stackTrace) => const LibraryAuthPlaceholder(),
    );
  }
}
