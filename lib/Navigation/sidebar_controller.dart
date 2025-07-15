import 'package:flutter/material.dart';
import 'model/navigation_item.dart';

class SidebarController extends ChangeNotifier {
  int _itemExpandedIndex = -1;
  int _selectedIndex = 0;
  int? _selectedSubIndex;
  late String _normalizedCurrentRoute;
  late List<String> _currentSegments;

  int get itemExpandedIndex => _itemExpandedIndex;
  int get selectedIndex => _selectedIndex;
  int? get selectedSubIndex => _selectedSubIndex;

  void updateFromRoute(String? currentRoute, List<dynamic> items) {
    if (currentRoute != null) {
      _normalizedCurrentRoute = _normalizeRoute(currentRoute);
      _currentSegments = _normalizedCurrentRoute.split('/');
      _updateSelectionFromRoute(items);
      notifyListeners();
    }
  }

  String _normalizeRoute(String route) {
    return route.replaceAll(RegExp(r'^/+|/+$'), '');
  }

  bool _routeMatches(String currentRoute, String itemRoute) {
    String normalizedItemRoute = _normalizeRoute(itemRoute);
    if (currentRoute == normalizedItemRoute) return true;

    List<String> itemSegments = normalizedItemRoute.split('/');
    if (itemSegments.length > _currentSegments.length) return false;

    for (int i = 0; i < itemSegments.length; i++) {
      int currentIndex = _currentSegments.length - itemSegments.length + i;
      if (currentIndex < 0 ||
          _currentSegments[currentIndex] != itemSegments[i]) {
        return false;
      }
    }
    return true;
  }

  void _updateSelectionFromRoute(List<dynamic> items) {
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (item is! NavigationItem) continue;

      if (item.route != null &&
          _routeMatches(_normalizedCurrentRoute, item.route!)) {
        _selectedIndex = i;
        _selectedSubIndex = null;
        if (item.subItems != null) {
          _itemExpandedIndex = i;
        }
        return;
      }

      if (item.subItems != null) {
        for (int j = 0; j < item.subItems!.length; j++) {
          if (item.subItems![j].route != null &&
              _routeMatches(
                  _normalizedCurrentRoute, item.subItems![j].route!)) {
            _selectedIndex = i;
            _selectedSubIndex = j;
            _itemExpandedIndex = i;
            return;
          }
        }
      }
    }
  }

  void handleMainItemTap(NavigationItem item, int index,
      Function(String)? onRouteSelected, String? currentRoute, onRoute) {
    if (item.subItems == null) {
      _itemExpandedIndex = -1;
    } else {
      _itemExpandedIndex = _itemExpandedIndex == index ? -1 : index;
    }

    _selectedIndex = index;
    _selectedSubIndex = null;

    if (item.onTap != null) {
      item.onTap!();
    } else if (item.route != null &&
        onRouteSelected != null &&
        currentRoute != null) {
      onRouteSelected(item.route!);
    } else if (onRoute == true) {
      onRouteSelected!(item.route!);
    }

    notifyListeners();
  }

  void handleSubItemTap(NavigationItem item, int index, int subIndex,
      Function(String)? onRouteSelected, String? currentRoute, bool onRoute) {
    _selectedIndex = index;
    _selectedSubIndex = subIndex;
    _itemExpandedIndex = index;

    if (item.subItems?[subIndex].onTap != null) {
      item.subItems![subIndex].onTap!();
    } else if (item.subItems?[subIndex].route != null &&
        onRouteSelected != null &&
        currentRoute != null) {
      onRouteSelected(item.subItems![subIndex].route!);
    } else if (onRoute == true) {
      onRouteSelected!(item.subItems![subIndex].route!);
    }

    notifyListeners();
  }
}
