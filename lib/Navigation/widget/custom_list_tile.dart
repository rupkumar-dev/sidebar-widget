import 'package:flutter/material.dart';

/// A customizable list tile widget that supports expansion, hover effects, and overlays.
///
/// This widget is primarily used in navigation menus and sidebars, providing features like:
/// * Expandable/collapsible children
/// * Hover effects with customizable colors
/// * Optional overlay display for collapsed state
/// * Animated transitions
class CustomListTile extends StatefulWidget {
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
    this.enableAnimation = true,
    this.showOverlay = false,
  });

  @override
  CustomListTileState createState() => CustomListTileState();
}

/// The State class for [CustomListTile].
///
/// Handles the animation, hover effects, and overlay display logic for the tile.
class CustomListTileState extends State<CustomListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.itemExpanded ?? false) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemExpanded != oldWidget.itemExpanded) {
      if (widget.itemExpanded ?? false) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + renderBox.size.width - 4,
        top: position.dy,
        child: Material(
          color: Colors.transparent,
          child: MouseRegion(
            onEnter: (_) => _isHovered = true,
            onExit: (_) {
              _isHovered = false;
              Future.delayed(const Duration(milliseconds: 300), () {
                if (!_isHovered && !widget.isExpanded!) {
                  _removeOverlay();
                }
              });
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children?.map((child) {
                      if (child is CustomListTile) {
                        return CustomListTile(
                          title: child.title,
                          icon: child.icon,
                          isSelected: child.isSelected,
                          isExpanded: true,
                          showOverlay: false,
                          onTap: child.onTap,
                        );
                      }
                      return child;
                    }).toList() ??
                    [],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.isSelected ?? false;
    final Color effectiveHoverColor =
        widget.hoverColor ?? Colors.black.withValues(alpha: 0.2);
    final Color effectiveSelectedColor =
        widget.selectedColor ?? Colors.white.withValues(alpha: 0.4);
    final bool hasChildren =
        widget.children != null && widget.children!.isNotEmpty;
    final bool isExpanded = widget.isExpanded ?? false;

    if (isExpanded && _overlayEntry != null) {
      _removeOverlay();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            if (widget.showOverlay && hasChildren && !isExpanded) {
              _showOverlay(context);
            }
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            if (widget.showOverlay && hasChildren) {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (!_isHovered && !isExpanded) {
                  _removeOverlay();
                }
              });
            }
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: isExpanded ? null : 36,
              margin: EdgeInsets.symmetric(
                horizontal: isExpanded ? 4.0 : 1.0,
                vertical: 2.0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isExpanded ? 8.0 : 2.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: (isSelected || _isHovered)
                    ? LinearGradient(
                        colors: [
                          _isHovered && !isSelected
                              ? effectiveHoverColor
                              : effectiveSelectedColor,
                          _isHovered && !isSelected
                              ? effectiveHoverColor.withValues(alpha: .05)
                              : effectiveSelectedColor.withValues(alpha: 0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: isSelected
                            ? widget.iconBagroundColor ?? effectiveSelectedColor
                            : Colors.transparent,
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                  if (isExpanded) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hasChildren)
                      Icon(
                        (widget.itemExpanded ?? false)
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.white,
                        size: 16,
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (isExpanded && hasChildren)
          ClipRect(
            child: SizeTransition(
              sizeFactor: widget.enableAnimation
                  ? _animation
                  : AlwaysStoppedAnimation(
                      widget.itemExpanded ?? false ? 1.0 : 0.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  children: widget.children ?? [],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isHovered = false;
  }
}
