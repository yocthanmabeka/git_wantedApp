import 'package:flutter/material.dart';

class WantedTabProvider extends ChangeNotifier {
  int _selectedTab = 0;
  bool _isSearching = false;

  int get selectedTab => _selectedTab;
  bool get isSearching => _isSearching;

  final TextEditingController searchController = TextEditingController();

  void setTab(int index) {
    _selectedTab = index;
    _isSearching = false;
    notifyListeners();
  }

  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  void cancelSearch() {
    _isSearching = false;
    searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
