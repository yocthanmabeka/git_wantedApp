import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wanted/models/model.dart';

class MockWantedService {
  /// ✅ Fetches all mock data (Users, Events, Lives, Memorials, and Activities)
  Future<WantedData> getWantedData() async {
    final userData = await _getUserData();
    final eventData = await _getEventData();
    final liveData = await _getLiveData();
    final memorialData = await _getMemorialData();
    final activities = await _getActivityData();

    return WantedData(userData, eventData, liveData, memorialData, activities);
  }

  /// ✅ Loads mock user data from JSON
  Future<List<UserModel>> _getUserData() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulating a delay
    final dataString = await _loadAsset('assets/sample_data/sample_user.json'); // Load JSON file
    final Map<String, dynamic> userJson = jsonDecode(dataString); // Parse JSON

    // Convert JSON data to a list of UserModel objects
    return userJson['users'] != null
        ? userJson['users'].map<UserModel>((v) => UserModel.fromJson(v)).toList()
        : [];
  }

  /// ✅ Loads mock event data from JSON
  Future<List<EventModel>> _getEventData() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulating a delay
    final jsonLoad = await _loadAsset('assets/sample_data/sample_event.json'); // Load JSON file
    final Map<String, dynamic> eventJson = jsonDecode(jsonLoad); // Parse JSON

    // Convert JSON data to a list of EventModel objects
    return eventJson['events'] != null
        ? eventJson['events'].map<EventModel>((v) => EventModel.fromJson(v)).toList()
        : [];
  }

  /// ✅ Loads mock live streaming data from JSON
  Future<List<LiveModel>> _getLiveData() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulating a delay
    final liveData = await _loadAsset('assets/sample_data/sample_live.json'); // Load JSON file
    final Map<String, dynamic> liveJson = jsonDecode(liveData); // Parse JSON

    // Convert JSON data to a list of LiveModel objects
    return liveJson['lives'] != null
        ? liveJson['lives'].map<LiveModel>((v) => LiveModel.fromJson(v)).toList()
        : [];
  }

  /// ✅ Loads mock memorial data from JSON
  Future<List<MemorialModel>> _getMemorialData() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulating a delay
    final memorialData = await _loadAsset('assets/sample_data/sample_memorial.json'); // Load JSON file

    try {
      final Map<String, dynamic> memorialJson = jsonDecode(memorialData); // Parse JSON

      // Check if the key "memorials" exists in JSON data
      if (memorialJson['memorials'] == null) {
        print("❌ Error: Key 'memorials' not found in JSON.");
        return [];
      }

      // Convert JSON data to a list of MemorialModel objects
      return memorialJson['memorials'].map<MemorialModel>((v) => MemorialModel.fromJson(v)).toList();
    } catch (e) {
      print("❌ Error while loading memorial data: $e"); // Handle potential parsing errors
      return [];
    }
  }

  /// ✅ Loads mock activity data from JSON
  Future<List<Activity>> _getActivityData() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulating a delay
    final activityData = await _loadAsset('assets/sample_data/sample_activity.json'); // Load JSON file
    final Map<String, dynamic> activityJson = jsonDecode(activityData); // Parse JSON

    // Convert JSON data to a list of Activity objects
    return activityJson['activities'] != null
        ? activityJson['activities'].map<Activity>((v) => Activity.fromJson(v)).toList()
        : [];
  }

  /// ✅ Utility function to load a JSON file from assets
  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}
