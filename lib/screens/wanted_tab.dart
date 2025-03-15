import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wanted/component/component.dart';
import 'package:wanted/screens/screens.dart';

/// The main navigation tab for the Wanted app.
/// It contains a bottom navigation bar and controls navigation between different sections.
class WantedTab extends StatefulWidget {
  final VoidCallback onNavigateToLive; // Callback to navigate to the live screen
  final VoidCallback onOpenDrawer; // Callback to open the user drawer

  const WantedTab({super.key, required this.onNavigateToLive, required this.onOpenDrawer});

  @override
  State<WantedTab> createState() => _WantedTabState();
}

class _WantedTabState extends State<WantedTab> with SingleTickerProviderStateMixin {
  int _selected = 0; // Index of the selected tab
  bool isSearching = false; // Whether the search bar is active
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController; // Controller for managing tabs in search mode

  // List of widgets representing different app sections
  List<Widget> wantedTabs = [
    const NewsFeed(), // News feed section
    MemorialScreen(), // Memorial section
    ActivityScreen(), // Activity section
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// Handles tab switching in the bottom navigation bar
  void _onTap(int index) {
    setState(() {
      _selected = index;
      isSearching = false; // Reset search mode when switching tabs
    });
  }

  /// Activates the search mode
  void _onSearchTap() {
    setState(() => isSearching = true);
  }

  /// Cancels the search mode and clears the search input
  void _onCancelSearch() {
    setState(() {
      isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom app bar with search functionality
      appBar: WantedAppBar(
        isSearching: isSearching,
        onSearchTap: _onSearchTap,
        onCancelSearch: _onCancelSearch,
        searchController: _searchController,
        tabController: _tabController,
        onNavigateToLive: widget.onNavigateToLive,
        onOpenDrawer: widget.onOpenDrawer,
      ),

      // Show either the search results or the selected tab content
      body: isSearching
          ? WantedSearchScreen(currentTab: _selected)
          : wantedTabs[_selected],

      // Floating button to create new content
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
        child: const Icon(Icons.add_rounded),
      ),

      // Bottom navigation bar for switching between sections
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.public_rounded), label: 'Memoring'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.handFist), label: 'Activity'),
        ],
      ),
    );
  }
}

/// Custom app bar for the Wanted app, including a search bar and tab navigation in search mode.
class WantedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNavigateToLive; // Callback for navigating to the live screen
  final VoidCallback onOpenDrawer; // Callback for opening the user drawer
  final bool isSearching; // Whether the search mode is active
  final VoidCallback onSearchTap; // Function to activate search mode
  final VoidCallback onCancelSearch; // Function to cancel search mode
  final TextEditingController searchController; // Controller for managing search input
  final TabController tabController; // Controller for managing search categories

  const WantedAppBar({
    super.key,
    required this.isSearching,
    required this.onSearchTap,
    required this.onCancelSearch,
    required this.searchController,
    required this.tabController,
    required this.onNavigateToLive,
    required this.onOpenDrawer,
  });

  @override
  Size get preferredSize => Size.fromHeight(isSearching ? kToolbarHeight + 50 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Live button only visible when not searching
                if (!isSearching)
                  GestureDetector(
                    onTap: onNavigateToLive,
                    child: const Icon(Icons.live_tv_rounded),
                  ),

                // Search bar input field
                Expanded(
                  child: TextField(
                    controller: searchController,
                    autofocus: isSearching,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Wanted...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: onSearchTap,
                  ),
                ),

                // Cancel or expand search button
                IconButton(
                  icon: Icon(isSearching ? Icons.cancel_outlined : Icons.expand_circle_down_outlined),
                  onPressed: isSearching ? onCancelSearch : onSearchTap,
                ),

                // Profile button only visible when not searching
                if (!isSearching)
                  GestureDetector(
                    onTap: onOpenDrawer,
                    child: const Icon(Icons.person),
                  ),
              ],
            ),
          ),

          // Search category tabs when search mode is active
          if (isSearching)
            DefaultTabController(
              length: 6,
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                tabs: [
                  "Événements récents",
                  "Commémorations",
                  "Mémoriaux célèbres",
                  "Personnes disparues",
                  "Hommages populaires",
                  "Tendances Wanted"
                ].map((suggestion) => Tab(text: suggestion)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
