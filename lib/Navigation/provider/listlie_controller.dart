import 'package:flutter/material.dart';

class ListTileController extends ChangeNotifier {
  bool _isHovered = false;
  bool get isHovered => _isHovered;

  void setHovered(bool value) {
    _isHovered = value;
    notifyListeners();
  }
}
