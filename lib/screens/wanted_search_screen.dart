import 'package:flutter/material.dart';

/// A search results screen that displays different content
/// based on the currently selected tab.
class WantedSearchScreen extends StatelessWidget {
  final int currentTab; // Represents the active tab (0 = Home, 1 = Events, 2 = Memoring)

  const WantedSearchScreen({super.key, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    // Determine the title based on the current tab
    String title;
    switch (currentTab) {
      case 0:
        title = "Searching in News Feed"; // Home tab
        break;
      case 1:
        title = "Searching in Events"; // Events tab
        break;
      case 2:
        title = "Searching in Memorials"; // Memoring tab
        break;
      default:
        title = "Search"; // Default title for unknown cases
    }

    return Scaffold(
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
