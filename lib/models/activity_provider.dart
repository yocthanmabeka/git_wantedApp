import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/models/model.dart';

/// **Provider pour gérer les activités en temps réel**
class ActivityProvider extends ChangeNotifier {
  final MockWantedService _mockWantedService = MockWantedService();
  List<Activity> _activities = [];
  int _selectedIndex = 0;

  /// ✅ **Liste des onglets pour filtrer les activités**
  final List<String> activityTabs = ["All", "Events", "Linked", "Upcoming"];

  ActivityProvider() {
    fetchActivities(); // Récupérer les activités au démarrage
  }

  List<Activity> get activities => _filteredActivities();
  int get selectedIndex => _selectedIndex;

  /// **🔄 Récupère toutes les activités depuis l'API**
  Future<void> fetchActivities() async {
    try {
      WantedData data = await _mockWantedService.getWantedData();
      _activities = data.activities;
      notifyListeners();
    } catch (e) {
      debugPrint("Erreur lors du chargement des activités: $e");
    }
  }

  /// **🔄 Filtre les activités selon l'onglet sélectionné**
  List<Activity> _filteredActivities() {
    switch (_selectedIndex) {
      case 1:
        return _activities
            .where((activity) => activity.type == "event_participation")
            .toList();
      case 2:
        return _activities
            .where((activity) => activity.type == "linked_activity")
            .toList();
      case 3:
        return _activities
            .where((activity) => activity.type == "upcoming_activity")
            .toList();
      default:
        return _activities;
    }
  }

  /// **🔄 Met à jour l'onglet sélectionné**
  void updateTabIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// **➕ Ajoute une nouvelle activité (quand un utilisateur suit quelqu'un, etc.)**
  void addActivity(Activity newActivity) {
    _activities.insert(0, newActivity);
    notifyListeners();
  }

  /// **❌ Supprime une activité spécifique**
  void removeActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }
}
