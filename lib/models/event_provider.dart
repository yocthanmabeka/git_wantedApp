import 'package:flutter/material.dart';

class EventManager extends ChangeNotifier {
  bool isExpanded = false;
  double lineHeight = 540;
  double baseHeight = 80;
  double expandedHeight = 200;
  double cardHeight = 625;

  int likes = 2000;
  int comments = 500;
  int shares = 300;

  void toggleExpand() {
    isExpanded = !isExpanded;
    double heightDiff = expandedHeight - baseHeight;
    lineHeight = isExpanded ? 540 + heightDiff : 540;
    cardHeight = isExpanded ? 625 + heightDiff : 625;
    notifyListeners();
  }

  void incrementLikes() {
    likes++;
    notifyListeners();
  }

  void incrementComments() {
    comments++;
    notifyListeners();
  }

  void incrementShares() {
    shares++;
    notifyListeners();
  }
}
