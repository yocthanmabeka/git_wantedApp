import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/component/event_list_view.dart';
import 'package:wanted/models/model.dart';

/// **NewsFeed Screen**
/// Displays the main news feed of the Wanted app, allowing users to browse
/// different event categories using a `TabBar`.
class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> with SingleTickerProviderStateMixin {
  
  // **TabController** to manage switching between "For You" and "Follow" tabs.
  late final TabController _newsFeedController;
  
  // Mock API service to fetch Wanted events data.
  final mockWantedService = MockWantedService();

  /// **Initialize the state**
  /// - Creates the `TabController` with two tabs.
  @override
  void initState() {
    _newsFeedController = TabController(length: filterTab.length, vsync: this);
    super.initState();
  }

  /// **Dispose of the controller to free resources**
  @override
  void dispose() {
    _newsFeedController.dispose();
    super.dispose();
  }

  /// **Tabs for filtering events**
  /// - "For You" → Personalized recommendations
  /// - "Follow" → Events from followed accounts
  List<Tab> filterTab = const [
    Tab(text: "For You", height: 40),
    Tab(text: "Follow", height: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WantedData>(
      future: mockWantedService.getWantedData(), // Fetch event data
      builder: (context, snapshot) {
        // ✅ Check if data is fully loaded
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              /// **Tab Bar for switching views**
              TabBar(
                controller: _newsFeedController,
                tabs: filterTab,
              ),

              /// **Tab Bar View to display content based on the selected tab**
              Expanded(
                flex: 2,
                child: TabBarView(
                  controller: _newsFeedController,
                  children: [
                    /// **Tab 1: "For You" - Personalized Event Feed**
                    EventListView(
                      event: snapshot.data?.eventData ?? [],
                      creator: snapshot.data?.userData ?? [],
                    ),

                    /// **Tab 2: "Follow" - Events from followed profiles**
                    EventListView(
                      event: snapshot.data?.eventData ?? [],
                      creator: snapshot.data?.userData ?? [],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // ✅ Show a loading spinner while fetching data
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
