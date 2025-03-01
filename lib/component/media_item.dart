import 'package:flutter/material.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // ✅ Fond gris clair
        borderRadius: BorderRadius.circular(3), // ✅ Bords arrondis
      ),
      child: const Center(
        child: Icon(Icons.image, size: 40, color: Colors.black45), // ✅ Icône image temporaire
      ),
    );
  }
}
