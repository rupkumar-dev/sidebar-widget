import 'package:flutter/material.dart';

/// Configuration for an item in the navigation widget.
class SidebarConfig {
  final Color? backgroundColor;

  final double? width;

  final EdgeInsets? padding;

  const SidebarConfig({
    this.backgroundColor,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
  });
}

/// Configuration for styling individual navigation items.
class ItemConfig {
  /// The color to use when an item is selected.
  final Color? selectedItemColor;

  /// The background color for the icon container.
  /// Note: "iconBagroundColor" appears to have a typo - consider renaming to "iconBackgroundColor"
  final Color? iconBagroundColor;

  /// The color to use for the icon itself.
  final Color? iconColor;

  /// The color to use for the item's text label.
  final Color? textColor;

  /// Creates a configuration for navigation item styling.
  ///
  /// All parameters are optional and will fall back to the default theme colors
  /// if not specified.
  const ItemConfig({
    this.selectedItemColor,
    this.iconBagroundColor,
    this.iconColor,
    this.textColor,
  });
}
