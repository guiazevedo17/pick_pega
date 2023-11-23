import 'package:flutter/material.dart';

class NavigationManager {
  static List<String> history = [];

  static void navigateTo(BuildContext context, String destination) {
    history.add(destination);

    Navigator.pushNamed(context, destination);
  }

  static String? getPreviousScreen() {
    if (history.length >= 1) {
      return history[history.length - 2];
    } else {
      return null; // Não há tela anterior
    }
  }
}
