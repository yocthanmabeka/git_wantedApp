import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/component/event_list_view.dart';

/// **ProfileScreen**
/// This screen displays the user's profile, including their details, followers, posts, and activities.
/// It includes a `NestedScrollView` with a `SliverAppBar` and a `TabBarView` to navigate between different sections.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late final TabController _profileController;
  final mockWantedService = MockWantedService(); // Mock service for fetching user data

  /// **Tabs for the profile sections**
  final List<Tab> profileTabs = const [
    Tab(text: "All"),
    Tab(text: "Answers"),
    Tab(text: "Organiz"),
    Tab(text: "Interact"),
  ];

  @override
  void initState() {
    super.initState();
    _profileController = TabController(length: profileTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          /// **SliverAppBar - Profile Header**
          SliverAppBar(
            pinned: true, // Keeps the app bar visible when scrolling
            expandedHeight: 635, // Expanded height for the profile details
            leading: const BackButton(), // Back button to navigate back
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)), // Search button
              IconButton(onPressed: () {}, icon: const Icon(Icons.file_upload_outlined)), // Upload button
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  /// **Profile Banner**
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: 330,
                    width: double.infinity,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Bingo',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),

                  /// **Profile Action Buttons**
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.tag_rounded)), // Tag icon
                        TextButton(onPressed: () {}, child: const Text('Alive')), // Status button
                        IconButton(onPressed: () {}, icon: const Icon(Icons.edit_rounded)), // Edit button
                      ],
                    ),
                  ),

                  /// **Username & Bio**
                  const Text(
                    'Username',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Short profile description',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),

                  /// **Profile Status Button**
                  ElevatedButton(onPressed: () {}, child: const Text('Alive')),

                  /// **Profile Stats: Followers, Following, Connection**
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('777', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            TextButton(onPressed: () {}, child: const Text('Following')),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('555', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            TextButton(onPressed: () {}, child: const Text('Followers')),
                          ],
                        ),
                        ElevatedButton(onPressed: () {}, child: const Text('Connect')), // Follow button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// **Pinned TabBar**
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _profileController,
                tabs: profileTabs,
                indicatorColor: Colors.blue, // Active tab indicator color
                labelColor: Colors.black, // Selected tab text color
                unselectedLabelColor: Colors.grey, // Unselected tab text color
              ),
            ),
          ),
        ],

        /// **TabBar View Content**
        body: TabBarView(
          controller: _profileController,
          children: [
            _buildTabContent("All"), // Displays all user activities
            _buildTabContent("Answer"), // Displays user responses
            _buildTabContent("Organiz"), // Displays organized events
            _buildTabContent("Interact"), // Displays interactions
          ],
        ),
      ),
    );
  }

  /// ✅ **Tab Content with FutureBuilder**
  /// Fetches and displays data dynamically based on the selected tab.
  Widget _buildTabContent(String tabName) {
    return FutureBuilder<WantedData>(
      future: mockWantedService.getWantedData(), // Fetch user data from mock service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show loading spinner
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}")); // Show error message
        } else if (!snapshot.hasData || snapshot.data!.eventData.isEmpty) {
          return const Center(child: Text("No content available")); // Show empty state
        }

        final events = snapshot.data!.eventData;
        final creators = snapshot.data!.userData;

        return EventListView(event: events, creator: creators);
      },
    );
  }
}

/// ✅ **SliverPersistentHeader for Sticky TabBar**
/// This keeps the `TabBar` visible at the top when scrolling.
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
