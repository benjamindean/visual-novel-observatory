import 'package:material_ui/material_ui.dart';

import 'character_fact.dart';
import 'character_fact_tile.dart';

class CharacterFactGrid extends StatelessWidget {
  const CharacterFactGrid({
    super.key,
    required this.facts,
  });

  final List<CharacterFact> facts;

  @override
  Widget build(BuildContext context) {
    if (facts.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: facts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 76,
      ),
      itemBuilder: (context, index) {
        return CharacterFactTile(fact: facts[index]);
      },
    );
  }
}
