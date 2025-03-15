import 'package:flutter/material.dart';
import 'package:wanted/models/model.dart';

class ProfileManager extends ChangeNotifier {
  //final AppCache _appCache = AppCache();

  // 🔹 Données du profil utilisateur
  String _username = '';
  String _email = '';
  String _profilePicture = '';
  bool _isPublicProfile = true;

  // 🔹 Getters
  String get username => _username;
  String get email => _email;
  String get profilePicture => _profilePicture;
  bool get isPublicProfile => _isPublicProfile;

  ProfileManager() {
    _loadProfileData();
  }

  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  /// ✅ **Récupère un utilisateur par son ID**
  UserModel getUserById(String id) {
    return _users.firstWhere(
      (user) => user.id == id,
      orElse: () => UserModel.defaultUser(),
    );
  }

  /// ✅ **Ajoute un nouvel utilisateur**
  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }

  /// 🔹 **Charge les données du profil depuis le cache**
  Future<void> _loadProfileData() async {
    Map<String, dynamic>? userData = await AppCache.getUser();
    if (userData != null) {
      _username = userData['username'] ?? '';
      _email = userData['email'] ?? '';
      _profilePicture = userData['profilePicture'] ?? '';
      _isPublicProfile = userData['isPublicProfile'] ?? true;
      notifyListeners();
    }
  }

  /// 🔹 **Met à jour les informations utilisateur**
  Future<void> updateProfile({
    String? username,
    String? email,
    String? profilePicture,
    bool? isPublicProfile,
  }) async {
    if (username != null) _username = username;
    if (email != null) _email = email;
    if (profilePicture != null) _profilePicture = profilePicture;
    if (isPublicProfile != null) _isPublicProfile = isPublicProfile;

    // Sauvegarde dans le cache
    await AppCache.saveUser({
      "username": _username,
      "email": _email,
      "profilePicture": _profilePicture,
      "isPublicProfile": _isPublicProfile,
    });

    notifyListeners();
  }

  /// 🔹 **Réinitialise le profil à ses valeurs par défaut**
  Future<void> resetProfile() async {
    _username = '';
    _email = '';
    _profilePicture = '';
    _isPublicProfile = true;

    await AppCache.logoutUser();
    notifyListeners();
  }
}
