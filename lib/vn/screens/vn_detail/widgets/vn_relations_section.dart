import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/vn_relation.dart';
import '../../../utils/vndb_content_sensitivity.dart';
import '../../../widgets/cached_app_image.dart';
import '../../../widgets/rating_badge.dart';
import '../../../widgets/image_placeholder.dart';
import '../../../../theme/app_theme.dart';
import '../../../../settings/providers/settings_provider.dart';

class VnRelationsSection extends StatelessWidget {
  final List<VnRelation> relations;

  const VnRelationsSection({super.key, required this.relations});

  @override
  Widget build(BuildContext context) {
    if (relations.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          child: Text(
            'Related Works',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            physics: const BouncingScrollPhysics(),
            itemCount: relations.length,
            itemBuilder: (context, index) {
              final relation = relations[index];

              return VnRelationCard(relation: relation);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class VnRelationCard extends ConsumerWidget {
  final VnRelation relation;

  const VnRelationCard({super.key, required this.relation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vn = relation.vn;
    final contentSettings = ref.watch(
      settingsProvider.select(
        (settings) => (
          showExplicitContent: settings.showExplicitContent,
          showViolentContent: settings.showViolentContent,
        ),
      ),
    );

    final shouldBlur = shouldBlurVndbContent(
      sexual: vn.imageSexual,
      violence: vn.imageViolence,
      showExplicitContent: contentSettings.showExplicitContent,
      showViolentContent: contentSettings.showViolentContent,
    );

    final label = _getRelationLabel(relation.relation);

    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            context.push('/detail', extra: vn);
          },
          child: Stack(
            children: [
              // Cover Image
              Positioned.fill(
                child: vn.imageUrl != null
                    ? CachedPosterImage(
                        imageUrl: vn.imageUrl!,
                        shouldBlur: shouldBlur,
                      )
                    : ImagePlaceholder(
                        backgroundColor: context.appSearchField,
                      ),
              ),

              // Blur Overlay for Sensitive Content
              if (shouldBlur)
                Positioned.fill(
                  child: Container(
                    color: context.appBackground.withValues(alpha: 0.65),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.visibility_off_rounded,
                      color: context.appTextPrimary.withValues(
                        alpha: 0.7,
                      ),
                      size: 24,
                    ),
                  ),
                ),

              // Bottom Gradient
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black26,
                        Colors.black54,
                        Colors.black87,
                      ],
                      stops: [0.0, 0.45, 0.75, 1.0],
                    ),
                  ),
                ),
              ),

              // Relation type badge at top left
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white24,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Title and details at bottom
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vn.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (vn.rating != null) ...[
                      const SizedBox(height: 4),
                      RatingBadge(
                        rating: vn.rating!,
                        iconSize: 10.0,
                        fontSize: 9.0,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRelationLabel(String relation) {
    switch (relation) {
      case 'seq':
        return 'Sequel';
      case 'preq':
        return 'Prequel';
      case 'alt':
        return 'Alt Version';
      case 'fan':
        return 'Fandisc';
      case 'side':
        return 'Side Story';
      case 'par':
        return 'Parent Work';
      case 'ser':
        return 'Series';
      case 'set':
        return 'Set';
      case 'char':
        return 'Shared Char';
      default:
        if (relation.isEmpty) {
          return 'Related';
        }

        return relation[0].toUpperCase() + relation.substring(1);
    }
  }
}
