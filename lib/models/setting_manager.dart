// import 'package:flutter/material.dart';
// import 'package:wanted/models/model.dart'; // Assurez-vous que AppCache est bien importé

// class SettingsManager extends ChangeNotifier {
//   //final AppCache _appCache = AppCache();

//   // 🔹 État des paramètres utilisateur
//   bool _isDarkMode = false;
//   bool _notificationsEnabled = true;
//   String _selectedLanguage = "Français";

//   // 🔹 Getters pour accéder aux valeurs des paramètres
//   bool get isDarkMode => _isDarkMode;
//   bool get notificationsEnabled => _notificationsEnabled;
//   String get selectedLanguage => _selectedLanguage;

//   SettingsManager() {
//     _loadSettings();
//   }

//   /// **🔹 Charge les paramètres utilisateur depuis le cache**
//   Future<void> _loadSettings() async {
//     Map<String, dynamic>? settings = await AppCache.getUserPreferences();
//     if (settings != null) {
//       _isDarkMode = settings["isDarkMode"] ?? false;
//       _notificationsEnabled = settings["notificationsEnabled"] ?? true;
//       _selectedLanguage = settings["selectedLanguage"] ?? "Français";
//       notifyListeners();
//     }
//   }

//   /// **🔹 Met à jour et sauvegarde les paramètres utilisateur**
//   Future<void> updateSettings({
//     bool? isDarkMode,
//     bool? notificationsEnabled,
//     String? selectedLanguage,
//   }) async {
//     if (isDarkMode != null) _isDarkMode = isDarkMode;
//     if (notificationsEnabled != null) _notificationsEnabled = notificationsEnabled;
//     if (selectedLanguage != null) _selectedLanguage = selectedLanguage;

//     // Sauvegarde dans le cache
//     await AppCache.saveUserPreferences({
//       "isDarkMode": _isDarkMode,
//       "notificationsEnabled": _notificationsEnabled,
//       "selectedLanguage": _selectedLanguage,
//     });

//     notifyListeners();
//   }

//   /// **🔹 Réinitialise les paramètres utilisateur aux valeurs par défaut**
//   Future<void> resetSettings() async {
//     _isDarkMode = false;
//     _notificationsEnabled = true;
//     _selectedLanguage = "Français";

//     // Efface uniquement les préférences utilisateur
//     await AppCache.saveUserPreferences({
//       "isDarkMode": _isDarkMode,
//       "notificationsEnabled": _notificationsEnabled,
//       "selectedLanguage": _selectedLanguage,
//     });

//     notifyListeners();
//   }
// }
