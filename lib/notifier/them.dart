import 'package:flutter/material.dart';

class MonTheme extends ChangeNotifier {
  static String _mode = "Jour"; // Valeur par défaut

  /// Définit le mode et notifie les widgets abonnés
  void setMode(String mode) {
    _mode = mode;
    notifyListeners();
  }

  /// Retourne le thème correspondant au mode actuel
  ThemeData getTheme() {
    return _mode == "Jour" ? ThemeData.light() : ThemeData.dark();
  }

  /// Retourne le mode actuel
  String get mode => _mode;
}
