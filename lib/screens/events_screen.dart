import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/component/event_list_view.dart';
import 'package:wanted/models/model.dart';

/// **EventsScreen**
/// This screen displays a list of events categorized into different tabs.
/// It fetches event data asynchronously and presents them in `TabBarView`.
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreen();
}

class _EventsScreen extends State<EventsScreen> with SingleTickerProviderStateMixin {
  // ✅ TabController for managing tab navigation
  late final TabController _eventsController;
  
  // ✅ Mock service to retrieve event data
  final mockWantedService = MockWantedService();

  @override
  void initState() {
    // Initialize TabController with the number of event categories
    _eventsController = TabController(length: eventTab.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _eventsController.dispose(); // Clean up resources
    super.dispose();
  }

  // ✅ List of tabs representing event categories
  final List<Widget> eventTab = const [
    Tab(text: "All", height: 40),        // All events
    Tab(text: "Answers", height: 40),    // Events with discussions
    Tab(text: "Organiz", height: 40),    // Organized events
    Tab(text: "Interact", height: 40),   // Interactive events
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WantedData>(
      future: mockWantedService.getWantedData(), // Fetch event data
      builder: (context, AsyncSnapshot<WantedData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              // ✅ Tab Bar for switching between event categories
              TabBar(
                controller: _eventsController,
                tabs: eventTab,
              ),
              Expanded(
                flex: 2,
                child: TabBarView(
                  controller: _eventsController,
                  children: [
                    // ✅ Each tab displays an event list filtered by category
                    EventListView(
                      event: snapshot.data?.eventData ?? [],
                      creator: snapshot.data?.userData ?? [],
                    ),
                    EventListView(
                      event: snapshot.data?.eventData ?? [],
                      creator: snapshot.data?.userData ?? [],
                    ),
                    EventListView(
                      event: snapshot.data?.eventData ?? [],
                      creator: snapshot.data?.userData ?? [],
                    ),
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
          // ✅ Show a loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
