import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final String? route;
  final List<Subitem>? subItems;
  final VoidCallback? onTap;

  NavigationItem({
    required this.title,
    required this.icon,
    this.route,
    this.subItems,
    this.onTap,
  });
}

class Subitem {
  final String title;
  final IconData? icon;
  final String? route;
  final VoidCallback? onTap;

  Subitem({
    required this.title,
    this.icon,
    this.route,
    this.onTap,
  });
}
