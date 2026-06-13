import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

class LibraryAuthPlaceholder extends StatelessWidget {
  const LibraryAuthPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: context.appBackground,
              titleSpacing: 20,
              centerTitle: false,
              title: Text(
                'Library',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.library_books_rounded,
                        size: 64,
                        color: context.appTextMuted,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your Library',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Connect your VNDB profile to sync your visual novel list, votes, and playing status.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: context.appTextMuted,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.appAccentTeal,
                          foregroundColor: context.colorScheme.onPrimary,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          context.push('/login');
                        },
                        child: const Text(
                          'Connect VNDB Profile',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
