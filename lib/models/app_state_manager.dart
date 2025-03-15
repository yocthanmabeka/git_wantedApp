import 'package:flutter/material.dart';
import 'package:wanted/models/model.dart';

class AppStateManager extends ChangeNotifier {
  // 🔹 Gestion de l'état utilisateur
  bool _loggedIn = false;
  bool _onboardingComplete = false;

  // 🔹 Gestion des onglets et de la recherche
  int _selectedTab = 0;
  bool _isSearching = false;

  final AppCache _appCache = AppCache();
  final TextEditingController searchController = TextEditingController();

  // 🔹 Getters pour récupérer les états
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get selectedTab => _selectedTab;
  bool get isSearching => _isSearching;

  // AppStateManager() {
  //   _loadAppState();
  // }

  /// 🔹 **Charge l'état de l'application au démarrage**
  Future<void> initializeApp() async {
    final user = await AppCache.getUser();
    _loggedIn = user != null; // Vérifie si un utilisateur est connecté
    _onboardingComplete = await AppCache.isOnboardingCompleted();
    notifyListeners();
  }

  /// 🔹 **Connexion de l'utilisateur**
  Future<void> loginUser(String username, String email, String password) async {
    _loggedIn = true;
    await AppCache.saveUser({
      "username": username,
      "email": email,
      "sessionToken": "random_generated_token"
    });

    notifyListeners();
  }

  /// 🔹 **Déconnexion de l'utilisateur**
  Future<void> logoutUser() async {
    await AppCache.logoutUser();
    await initializeApp();
    _loggedIn = false;
    notifyListeners();
  }

  /// 🔹 **Compléter l'onboarding**
  Future<void> completeOnboarding() async {
    _onboardingComplete = true;
    await AppCache.completeOnboarding();
    notifyListeners();
  }

  /// 🔹 **Changer d'onglet**
  void setTab(int index) {
    _selectedTab = index;
    _isSearching = false;
    notifyListeners();
  }

  /// 🔹 **Démarrer la recherche**
  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  /// 🔹 **Annuler la recherche**
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


// import 'package:flutter/material.dart';
// import 'package:wanted/models/model.dart';

// class AppStateManager extends ChangeNotifier {
//   // 🔹 Gestion de l'état utilisateur
//   bool _loggedIn = false;
//   bool _onboardingComplete = false;

//   // 🔹 Gestion des onglets et de la recherche
//   int _selectedTab = 0;
//   bool _isSearching = false;

//   final AppCache _appCache = AppCache();
//   final TextEditingController searchController = TextEditingController();

//   // 🔹 Getters pour récupérer les états
//   bool get isLoggedIn => _loggedIn;
//   bool get isOnboardingComplete => _onboardingComplete;
//   int get selectedTab => _selectedTab;
//   bool get isSearching => _isSearching;

//   AppStateManager() {
//     _loadAppState();
//   }

//   /// 🔹 **Charge l'état de l'application au démarrage**
//   Future<void> _loadAppState() async {
//     _loggedIn = await _appCache. != null;
//     _onboardingComplete = await _appCache.isOnboardingCompleted();
//     notifyListeners();
//   }

//   /// 🔹 **Connexion de l'utilisateur**
//   Future<void> loginUser(String username, String email, String password) async {
//     await _appCache.saveUser({
//       "username": username,
//       "email": email,
//       "sessionToken": "random_generated_token"
//     });

//     _loggedIn = true;
//     notifyListeners();
//   }

//   /// 🔹 **Déconnexion de l'utilisateur**
//   Future<void> logoutUser() async {
//     await _appCache.logoutUser();
//     _loggedIn = false;
//     notifyListeners();
//   }

//   /// 🔹 **Compléter l'onboarding**
//   Future<void> completeOnboarding() async {
//     await _appCache.completeOnboarding();
//     _onboardingComplete = true;
//     notifyListeners();
//   }

//   /// 🔹 **Changer d'onglet**
//   void setTab(int index) {
//     _selectedTab = index;
//     _isSearching = false;
//     notifyListeners();
//   }

//   /// 🔹 **Démarrer la recherche**
//   void startSearch() {
//     _isSearching = true;
//     notifyListeners();
//   }

//   /// 🔹 **Annuler la recherche**
//   void cancelSearch() {
//     _isSearching = false;
//     searchController.clear();
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
// }
