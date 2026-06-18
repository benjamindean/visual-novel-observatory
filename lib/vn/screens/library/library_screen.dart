import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/providers/auth_provider.dart';
import 'library_auth_placeholder.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final ScrollController _outerScrollController = ScrollController();
  final GlobalKey<NestedScrollViewState> _nestedScrollViewKey =
      GlobalKey<NestedScrollViewState>();

  @override
  void dispose() {
    _outerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(
      authProvider.select((state) => state.isAuthenticated),
    );

    if (!isAuthenticated) {
      return const LibraryAuthPlaceholder();
    }

    return LibraryContent(
      nestedScrollViewKey: _nestedScrollViewKey,
      outerScrollController: _outerScrollController,
    );
  }
}
