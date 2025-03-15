import 'package:flutter/material.dart';
import 'package:wanted/models/model.dart';

class EventLiveProvider extends ChangeNotifier {
   List<LiveModel> _liveEvents = [];

  List<LiveModel> get liveEvents => _liveEvents;

  void setLiveEvents(List<LiveModel> liveEvents) {
    _liveEvents = liveEvents;
    notifyListeners();
  }

  /// ✅ **Récupère un Live par son ID**
  LiveModel? getLiveById(String? id) {
    return _liveEvents.firstWhere((live) => live.id == id, orElse: LiveModel.defaultLive);
  }
  int _viewersCount = 0; // Nombre de spectateurs
  List<String> _chatMessages = []; // Liste des messages du chat
  bool _isLive = true; // État du live

  // 📡 Getter pour récupérer le nombre de spectateurs
  int get viewersCount => _viewersCount;

  // 💬 Getter pour récupérer la liste des messages du chat
  List<String> get chatMessages => _chatMessages;

  // 🎥 Getter pour savoir si le live est actif
  bool get isLive => _isLive;

  // 📡 Mettre à jour le nombre de spectateurs
  void updateViewers(int count) {
    _viewersCount = count;
    notifyListeners(); // 🔄 Met à jour les widgets qui écoutent
  }

  // 💬 Ajouter un message au chat
  void addMessage(String message) {
    _chatMessages.add(message);
    notifyListeners(); // 🔄 Met à jour l'affichage du chat
  }

  // 🎥 Terminer le live
  void endLive() {
    _isLive = false;
    notifyListeners();
  }
}
