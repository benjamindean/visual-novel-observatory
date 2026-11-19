import 'package:material_ui/material_ui.dart';

import '../../../theme/app_theme.dart';
import '../../widgets/connect_vndb_button.dart';

class LibraryAuthPlaceholder extends StatelessWidget {
  const LibraryAuthPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        top: false,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
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
                      const SizedBox(height: 16),
                      Text(
                        'Your Library',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.appTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Connect your VNDB profile to sync your visual novel list, votes, and playing status.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: context.appTextMuted,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const ConnectVndbButton(),
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
