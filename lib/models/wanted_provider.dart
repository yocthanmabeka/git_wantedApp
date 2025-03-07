import 'package:flutter/material.dart';

/// ✅ Provider pour gérer le `PageController` et la navigation dans WantedView.
class WantedProvider extends ChangeNotifier {
  final PageController _wantController = PageController(initialPage: 1);

  PageController get wantController => _wantController;

  /// 🔹 Aller à la page Live
  void goToLive() {
    _wantController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  /// 🔹 Ouvrir le Drawer (Profil)
  void openDrawer() {
    _wantController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  /// 🔹 Fermer la page et revenir au WantedTab (Page principale)
  void closePage() {
    _wantController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _wantController.dispose();
    super.dispose();
  }
}
