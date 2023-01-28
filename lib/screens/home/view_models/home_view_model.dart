import 'package:flutter/material.dart';

class HomeVm extends ChangeNotifier{

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

}