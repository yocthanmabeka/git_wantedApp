import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanted/models/memorial_model.dart';
import 'package:wanted/screens/memorial_detail_screen.dart';

/// **MemorialStaggeredGrid**
/// Displays a list of memorials in a **staggered grid layout**.
class MemorialStaggeredGrid extends StatelessWidget {
  final List<MemorialModel> memorial; // List of memorials to display

  /// **Constructor**
  /// Requires a list of `MemorialModel` objects.
  const MemorialStaggeredGrid({
    super.key,
    required this.memorial,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      // ✅ Defines the grid layout with 3 columns
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: memorial.length, // ✅ Number of items in the grid
      itemBuilder: (context, index) {
        final memorials = memorial[index]; // ✅ Get the current memorial

        return GestureDetector(
          onTap: () {
            // ✅ Navigate to the MemorialDetailScreen when clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemorialDetailScreen(memorial: memorials),
              ),
            );
          },
          child: Card(
            elevation: 4, // ✅ Adds a shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // ✅ Rounded corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //✅ Display memorial image (Uncomment if media is available)
                if (memorials.media.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      memorials.media.first.url, // ✅ Load the first image
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                // ✅ Display memorial name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    memorials.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
