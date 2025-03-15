import 'package:flutter/material.dart';
import 'package:wanted/api/mock_wanted_service.dart';
import 'package:wanted/models/model.dart';

/// **Provider pour gérer les mémoriaux dynamiquement**
class MemorialProvider extends ChangeNotifier {
  final MockWantedService _mockWantedService = MockWantedService();
  
  List<MemorialModel> _memorials = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MemorialModel> get memorials => _memorials;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// **🔄 Récupère les mémoriaux depuis l'API**
  Future<void> fetchMemorials() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      WantedData data = await _mockWantedService.getWantedData();
      if (data.memorialData.isNotEmpty) {
        _memorials = data.memorialData;
      } else {
        _memorials = [];
        _errorMessage = "Aucun mémorial trouvé.";
      }
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des mémoriaux: $e";
      debugPrint(_errorMessage);
    }

    _isLoading = false;
    notifyListeners();
  }

  /// ✅ **Récupère un mémorial par son ID**
  MemorialModel? getMemorialById(String? id) {
    try {
      return _memorials.firstWhere(
        (memorial) => memorial.id == id,
        orElse: () => MemorialModel.defaultMemorial(),
      );
    } catch (e) {
      debugPrint("Erreur getMemorialById: $e");
      return null;
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


// import 'package:flutter/material.dart';
// import 'package:wanted/api/mock_wanted_service.dart';
// import 'package:wanted/models/model.dart';

// /// **Provider pour gérer les mémoriaux dynamiquement**
// class MemorialProvider extends ChangeNotifier {
//   final MockWantedService _mockWantedService = MockWantedService();


//   List<MemorialModel> _memorials = [];

//   List<MemorialModel> get memorials => _memorials;

//   void setMemorials(List<MemorialModel> memorials) {
//     _memorials = memorials;
//     notifyListeners();
//   }

//   /// ✅ **Récupère un mémorial par son ID**
//   MemorialModel? getMemorialById(String? id) {
//     return _memorials.firstWhere((memorial) => memorial.id == id, orElse: () => null);
//   }

//   MemorialProvider() {
//     fetchMemorials(); // Charge les mémoriaux au démarrage
//   }

//   /// **🔄 Récupère les mémoriaux depuis l'API**
//   Future<void> fetchMemorials() async {
//     try {
//       WantedData data = await _mockWantedService.getWantedData();
//       _memorials = data.memorialData; // ✅ Correction de type
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Erreur lors du chargement des mémoriaux: $e");
//     }
//   }

//   /// **➕ Ajoute un nouveau mémorial**
//   void addMemorial(MemorialModel newMemorial) {
//     _memorials.insert(0, newMemorial);
//     notifyListeners();
//   }

//   /// **❌ Supprime un mémorial**
//   void removeMemorial(MemorialModel memorial) {
//     _memorials.remove(memorial);
//     notifyListeners();
//   }
// }
