import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/visual_novel.dart';
import '../../../widgets/detail_header.dart';
import '../../../widgets/languages_section.dart';
import '../../../widgets/links_section.dart';
import '../../../widgets/metadata_row.dart';
import '../../../widgets/platforms_section.dart';
import '../../../widgets/screenshots_section.dart';
import '../../../widgets/synopsis_section.dart';
import '../../../widgets/tags_section.dart';
import '../../../widgets/vndb_source_note.dart';
import 'vn_detail_actions.dart';
import 'vn_detail_status_notice.dart';
import 'vn_relations_section.dart';
import 'vn_releases_section.dart';

class VnDetailScaffold extends StatelessWidget {
  const VnDetailScaffold({super.key, required this.vn});

  final VisualNovel vn;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.6,
            collapsedHeight: size.height * 0.6,
            toolbarHeight: size.height * 0.6,
            stretch: true,
            pinned: false,
            automaticallyImplyLeading: false,
            backgroundColor: context.appBackground,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              stretchModes: const [
                StretchMode.zoomBackground,
              ],
              background: DetailHeader(vn: vn),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  VnDetailActions(vn: vn),

                  const SizedBox(height: 24),

                  if (vn.devStatus == 2) ...[
                    VnDetailStatusNotice(vn: vn),
                    const SizedBox(height: 20),
                  ],

                  // Metadata Row (Release, Playtime)
                  MetadataRow(vn: vn),
                  const SizedBox(height: 20),

                  // Synopsis Section (Expandable description)
                  if (vn.description != null && vn.description!.isNotEmpty) ...[
                    SynopsisSection(description: vn.description!),
                    const SizedBox(height: 24),
                  ],

                  // Tags List
                  TagsSection(tags: vn.tags, initialLimit: 6),
                  if (vn.tags.isNotEmpty) const SizedBox(height: 24),

                  // Platforms Section
                  PlatformsSection(platforms: vn.platforms),
                  if (vn.platforms.isNotEmpty) const SizedBox(height: 24),

                  if (vn.originalLanguage != null || vn.languages.isNotEmpty)
                    LanguagesSection(
                      originalLanguage: vn.originalLanguage,
                      languages: vn.languages,
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          if (vn.screenshots.isNotEmpty)
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ScreenshotsSection(screenshots: vn.screenshots),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // External Links Section
                  LinksSection(
                    vnId: vn.id,
                    extLinks: vn.extLinks,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (vn.voiceActors.isNotEmpty) ...[
                //   CharactersSection(
                //     vnId: vn.id,
                //     voiceActors: vn.voiceActors,
                //   ),
                //   const SizedBox(height: 24),
                // ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: VnReleasesSection(vnId: vn.id),
                ),
                VnRelationsSection(relations: vn.relations),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: VndbSourceNote()),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
