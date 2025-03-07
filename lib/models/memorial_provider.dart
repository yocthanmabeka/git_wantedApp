import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/models/model.dart';

/// **Provider pour gérer les mémoriaux dynamiquement**
class MemorialProvider extends ChangeNotifier {
  final MockWantedService _mockWantedService = MockWantedService();
  List<MemorialModel> _memorials = [];

  /// ✅ Récupère la liste des mémoriaux
  List<MemorialModel> get memorials => _memorials;

  MemorialProvider() {
    fetchMemorials(); // Charge les mémoriaux au démarrage
  }

  /// **🔄 Récupère les mémoriaux depuis l'API**
  Future<void> fetchMemorials() async {
    try {
      WantedData data = await _mockWantedService.getWantedData();
      _memorials = data.memorialData; // ✅ Correction de type
      notifyListeners();
    } catch (e) {
      debugPrint("Erreur lors du chargement des mémoriaux: $e");
    }
  }

  /// **➕ Ajoute un nouveau mémorial**
  void addMemorial(MemorialModel newMemorial) {
    _memorials.insert(0, newMemorial);
    notifyListeners();
  }

  /// **❌ Supprime un mémorial**
  void removeMemorial(MemorialModel memorial) {
    _memorials.remove(memorial);
    notifyListeners();
  }
}
