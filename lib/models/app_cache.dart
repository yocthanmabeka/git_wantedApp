import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const String _cacheKeyPosts = "cached_posts";
  static const String _onboardingCompletedKey = "onboarding_completed";
  static const String _userKey = "cached_user";
  static const String _cacheKeyUserProfile = "cached_user_profile";
  static const String _cacheKeyMessages = "cached_messages";
  static const String _cacheKeySession = "cached_session";
  static const String _cacheKeyPreferences = "cached_preferences";
  
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// 🔹 **Sauvegarde les informations utilisateur**
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userData));
  }

  /// 🔹 **Récupère les informations utilisateur**
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    return userJson != null ? jsonDecode(userJson) : null;
  }

  /// ✅ Sauvegarde des publications récentes en cache
  static Future<void> savePosts(List<Map<String, dynamic>> posts) async {
    final prefs = await _getPrefs();
    await prefs.setString(_cacheKeyPosts, jsonEncode(posts));
  }

  /// ✅ Récupération des publications mises en cache
  static Future<List<Map<String, dynamic>>> getPosts() async {
    final prefs = await _getPrefs();
    final data = prefs.getString(_cacheKeyPosts);
    return data != null ? List<Map<String, dynamic>>.from(jsonDecode(data)) : [];
  }

  /// ✅ Sauvegarde du profil utilisateur
  static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    final prefs = await _getPrefs();
    await prefs.setString(_cacheKeyUserProfile, jsonEncode(profile));
  }

  /// ✅ Récupération du profil utilisateur
  static Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await _getPrefs();
    final data = prefs.getString(_cacheKeyUserProfile);
    return data != null ? jsonDecode(data) : null;
  }

  /// ✅ Sauvegarde des messages récents
  static Future<void> saveMessages(List<Map<String, dynamic>> messages) async {
    final prefs = await _getPrefs();
    await prefs.setString(_cacheKeyMessages, jsonEncode(messages));
  }

  /// ✅ Récupération des messages récents
  static Future<List<Map<String, dynamic>>> getMessages() async {
    final prefs = await _getPrefs();
    final data = prefs.getString(_cacheKeyMessages);
    return data != null ? List<Map<String, dynamic>>.from(jsonDecode(data)) : [];
  }

  /// ✅ Sauvegarde du token de session
  static Future<void> saveSessionToken(String token) async {
    final prefs = await _getPrefs();
    await prefs.setString(_cacheKeySession, token);
  }

  /// ✅ Récupération du token de session
  static Future<String?> getSessionToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_cacheKeySession);
  }

  /// 🔹 **Sauvegarde l'état de l'onboarding**
  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
  }

  /// 🔹 **Vérifie si l'onboarding est complété**
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  /// 🔹 **Déconnexion de l'utilisateur**
  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_cacheKeySession);
    await prefs.remove(_onboardingCompletedKey);
  }

  /// ✅ Sauvegarde des préférences utilisateur
  static Future<void> saveUserPreferences(Map<String, dynamic> preferences) async {
    final prefs = await _getPrefs();
    await prefs.setString(_cacheKeyPreferences, jsonEncode(preferences));
  }

  /// ✅ Récupération des préférences utilisateur
  static Future<Map<String, dynamic>?> getUserPreferences() async {
    final prefs = await _getPrefs();
    final data = prefs.getString(_cacheKeyPreferences);
    return data != null ? jsonDecode(data) : null;
  }

  /// ✅ Effacer toutes les données du cache
  static Future<void> clearCache() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }
}