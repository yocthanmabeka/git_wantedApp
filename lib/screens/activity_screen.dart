import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/component/activity_item.dart';
import 'package:wanted/models/model.dart';

/// **ActivityScreen**
/// This screen displays user activities such as events, linked activities, and upcoming activities.
/// It includes a tab-based filter to categorize different types of activities.
class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedIndex = 0; // Tracks the currently selected tab
  final mockWantedService = MockWantedService(); // Mock data service

  // List of activity filter tabs
  final List<String> activityTabs = ["All", "Events", "Linked", "Upcoming"];

  /// **Handles tab selection**
  /// Updates the `_selectedIndex` to reflect the current tab
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WantedData>(
      future: mockWantedService.getWantedData(), // Fetches activity data
      builder: (context, AsyncSnapshot<WantedData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text("❌ Error loading activities."));
          }

          // ✅ **Retrieve all activities**
          List<Activity> allActivities = snapshot.data!.activities;
          
          // ✅ **Filter activities based on the selected tab**
          List<Activity> filteredActivities;
          switch (_selectedIndex) {
            case 1: // Events
              filteredActivities = allActivities
                  .where((activity) => activity.type == "event_participation")
                  .toList();
              break;
            case 2: // Linked Activities
              filteredActivities = allActivities
                  .where((activity) => activity.type == "linked_activity")
                  .toList();
              break;
            case 3: // Upcoming Activities
              filteredActivities = allActivities
                  .where((activity) => activity.type == "upcoming_activity")
                  .toList();
              break;
            default: // All Activities
              filteredActivities = allActivities;
              break;
          }

          return Column(
            children: [
              // ✅ **Tab Navigation Buttons**
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(activityTabs.length, (index) {
                    return ElevatedButton(
                      onPressed: () => _onTabSelected(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedIndex == index ? Colors.blue : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        activityTabs[index],
                        style: TextStyle(
                          color: _selectedIndex == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // ✅ **Display Filtered Activities**
              Expanded(
                child: filteredActivities.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: filteredActivities
                              .map((activity) => ActivityItem(activity: activity))
                              .toList(),
                        ),
                      )
                    : const Center(
                        child: Text("📭 No activities available."),
                      ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator()); // Loader while fetching data
        }
      },
    );
  }
}
