import 'package:flutter/material.dart';
import 'package:wanted/models/model.dart';

/// **MemorialDetailScreen**
/// Displays detailed information about a specific memorial.
/// Includes biography, tributes, donations, participants, and a souvenir shop.
class MemorialDetailScreen extends StatelessWidget {
  final MemorialModel memorial;

  const MemorialDetailScreen({super.key, required this.memorial});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memorial.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement sharing functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Display first image from memorial media (if available)
            if (memorial.media.isNotEmpty)
              Image.asset(
                memorial.media.first.url,
                width: double.infinity,
                height: 650,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 10),

            // ✅ Biography Section
            _buildSectionTitle("Biography"),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memorial.tributeMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Show more history (premium option)
                    },
                    child: const Text("View More (Premium)"),
                  ),
                ],
              ),
            ),

            // ✅ Tribute Section
            _buildSectionTitle("Tribute"),
            _buildCard(
              child: Column(
                children: [
                  ...memorial.tributes.map((tribute) => _buildMessage(
                        tribute.userId,
                        tribute.message,
                      )),
                  TextButton(
                    onPressed: () {
                      // TODO: Show more tributes (premium option)
                    },
                    child: const Text("View More Tributes (Premium)"),
                  ),
                ],
              ),
            ),

            // ✅ Donation Section
            _buildSectionTitle("Memorial Fund for ${memorial.name}"),
            _buildCard(
              child: Column(
                children: [
                  const Text("Goal: €10,000"),
                  const LinearProgressIndicator(value: 0.6),
                  const Text("€6,000 raised"),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement donation functionality
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text("Make a Donation"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Participants Section
            if (memorial.participants.isNotEmpty)
              _buildSectionTitle("Participants"),
            _buildCard(
              child: Wrap(
                spacing: 10,
                children: memorial.participants.map((participant) {
                  return Chip(
                    label: Text(participant),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Souvenir Shop Section
            _buildSectionTitle("Souvenir Shop"),
            _buildCard(
              child: Column(
                children: [
                  _buildShopItem(Icons.library_books_outlined, "Digital Photo Album", "€5"),
                  _buildShopItem(Icons.video_library_outlined, "Memorial Video", "€10"),
                  _buildShopItem(Icons.recent_actors_outlined, "Virtual Tribute Card", "€2"),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ✅ Widget for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ✅ Widget for content cards
  Widget _buildCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }

  /// ✅ Widget for tribute messages
  Widget _buildMessage(String author, String message) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
    );
  }

  /// ✅ Widget for the souvenir shop items
  Widget _buildShopItem(IconData icon, String title, String price) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        // TODO: Add item to souvenir collection
      },
    );
  }
}
