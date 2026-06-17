import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vn_providers.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../settings/providers/settings_provider.dart';
import 'widgets/home_scroll_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      ref.read(authProvider.notifier).loadCachedAuth();
      ref.read(settingsProvider.notifier).loadSettings();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(vnListProvider.notifier).fetchVns();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(homeDoubleTapProvider, (previous, next) {
      if (next > 0 && _scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: HomeScrollView(
          scrollController: _scrollController,
        ),
      ),
    );
  }
}
