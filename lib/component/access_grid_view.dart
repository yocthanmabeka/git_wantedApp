import 'package:flutter/material.dart';
import 'package:wanted/component/media_item.dart';

class AccessGridView extends StatelessWidget {
  const AccessGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // ✅ Affichage en grille 3x3
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 1, // ✅ Garde un format carré
      ),
      itemCount: 18, // ✅ Nombre d'éléments (modifiable selon les besoins)
      itemBuilder: (context, index) {
        return const MediaItem();
      },
    );
  }
}
