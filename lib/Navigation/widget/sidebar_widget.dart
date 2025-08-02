import 'package:flutter/material.dart';

import 'custom_list_tile.dart';

import '../model/navigation_item.dart';

class SidebarWidget extends StatelessWidget {
  final NavigationItem item;
  final int index;
  final bool itemExpanded;
  final bool isSelected;
  final int? selectedSubIndex;
  final VoidCallback itemOnTap;
  final Function(int) onSubItemTap;
  final Color? selectedColor;
  final Color? iconBagroundColor;
  final Color? iconColor;
  final Color? textColor;

  const SidebarWidget({
    super.key,
    required this.item,
    required this.index,
    required this.itemExpanded,
    required this.isSelected,
    required this.itemOnTap,
    required this.onSubItemTap,
    this.selectedSubIndex,
    this.selectedColor,
    this.iconBagroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final subItemsList = item.subItems?.asMap().entries.map((entry) {
      final int subIndex = entry.key;
      final sub = entry.value;
      return CustomListTile(
        iconBagroundColor: iconBagroundColor,
        iconColor: iconColor,
        textColor: textColor,
        key: ValueKey(index * 100 + subIndex),
        selectedColor: selectedColor,
        isSelected: selectedSubIndex == subIndex && isSelected,
        title: sub.title,
        icon: sub.icon ?? Icons.subdirectory_arrow_right,
        onTap: () => onSubItemTap(subIndex),
      );
    }).toList();

    return CustomListTile(
      key: ValueKey('main_item_$index'),
      selectedColor: selectedColor,
      iconBagroundColor: iconBagroundColor,
      iconColor: iconColor,
      textColor: textColor,
      title: item.title,
      icon: item.icon,
      itemExpanded: itemExpanded,
      isSelected: isSelected,
      onTap: itemOnTap,
      children: subItemsList ?? const [],
    );
  }
}
