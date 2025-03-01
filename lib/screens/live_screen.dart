import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/component/component.dart';
import 'package:wanted/models/model.dart';

/// **LiveScreen**
/// This screen displays ongoing live sessions, events, and creators.
/// It fetches data asynchronously and passes it to `LivePageView`.
class LiveScreen extends StatefulWidget {
  final VoidCallback closePage; // Function to close the live screen

  const LiveScreen({super.key, required this.closePage});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  // Mock service to retrieve live session data
  final mockWantedService = MockWantedService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WantedData>(
      // Fetches live, event, and user data asynchronously
      future: mockWantedService.getWantedData(),
      builder: (context, snapshot) {
        // ✅ Show a loading indicator while data is being retrieved
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ✅ Show an error message if data is unavailable or an error occurs
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("An error occurred or no data available."));
        }

        // ✅ Extract event, user, and live session data
        final List<EventModel> events = snapshot.data!.eventData;
        final List<UserModel> creators = snapshot.data!.userData;
        final List<LiveModel> liveSessions = snapshot.data!.liveData;

        // ✅ Display the LivePageView with the retrieved data
        return LivePageView(
          closePage: widget.closePage,
          event: events,
          creator: creators,
          live: liveSessions,
        );
      },
    );
  }
}
