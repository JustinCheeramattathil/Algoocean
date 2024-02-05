import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier{
    int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}