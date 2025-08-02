import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/listlie_controller.dart';

/// A customizable list tile widget that supports expansion, hover effects, and overlays.
///
/// This widget is primarily used in navigation menus and sidebars, providing features like:
/// * Expandable/collapsible children
/// * Hover effects with customizable colors
/// * Optional overlay display for collapsed state
/// * Animated transitions
class CustomListTile extends StatelessWidget {
  /// The text to display in the list tile.
  final String title;

  /// The icon to display at the start of the list tile.
  final IconData icon;

  /// Optional list of child widgets to display when the tile is expanded.
  ///
  /// These children are typically other [CustomListTile] widgets to create
  /// a nested navigation structure.
  final List<Widget>? children;

  /// Whether to enable expansion/collapse animations.
  ///
  /// When true, children will animate in/out when expanding/collapsing.
  /// When false, children will appear/disappear instantly.
  /// Defaults to true.
  final bool enableAnimation;

  final bool? isSelected;
  final bool? isExpanded;
  final bool? itemExpanded;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? iconBagroundColor;
  final Color? hoverColor;
  final Color? iconColor;
  final Color? textColor;
  final bool showOverlay;
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    this.children,
    this.isSelected,
    this.isExpanded = true,
    this.itemExpanded,
    this.onTap,
    this.selectedColor,
    this.iconBagroundColor,
    this.hoverColor,
    this.iconColor,
    this.textColor,
    this.enableAnimation = true,
    this.showOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasChildren = children?.isNotEmpty ?? false;
    final bool isExpandedValue = isExpanded ?? true;
    final bool isSelectedValue = isSelected ?? false;
    final Color effectiveHoverColor =
        hoverColor ?? Colors.black.withValues(alpha: 0.2);
    final Color effectiveSelectedColor =
        selectedColor ?? Colors.white.withValues(alpha: 0.4);

    final iconWidget = SizedBox(
      width: 22,
      height: 22,
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: isSelectedValue ? 1.1 : 1.0,
          curve: Curves.easeInOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelectedValue
                  ? iconBagroundColor ?? effectiveSelectedColor
                  : Colors.transparent,
            ),
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: 12,
            ),
          ),
        ),
      ),
    );

    return ChangeNotifierProvider(
      lazy: true,
      create: (_) => ListTileController(),
      child: Consumer<ListTileController>(
        builder: (context, controller, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(
                  left: isSelectedValue ? 4.0 : 0.0,
                  top: isSelectedValue ? 1.0 : 0.0,
                  bottom: isSelectedValue ? 0.0 : 1.0,
                ),
                child: InkWell(
                  onHover: context.read<ListTileController>().setHovered,
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOutCubic,
                    width: isExpandedValue ? null : 42,
                    margin: EdgeInsets.symmetric(
                      horizontal: isExpandedValue ? 1.0 : 1.0,
                      vertical: 1.8,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isExpandedValue ? 10.0 : 4.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: (isSelectedValue || controller.isHovered)
                          ? (isSelectedValue
                              ? effectiveSelectedColor
                              : effectiveHoverColor)
                          : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconWidget,
                        if (isExpandedValue) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: textColor ?? Colors.white,
                                fontWeight: isSelectedValue
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (hasChildren)
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 200),
                              turns: (itemExpanded ?? false) ? 0.25 : 0.0,
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              if (isExpandedValue && hasChildren)
                ClipRect(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: (itemExpanded ?? false)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(children: children ?? []),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
