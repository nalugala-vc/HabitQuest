import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class NavWidget extends StatefulWidget {
  final Widget icon;
  final String name;
  final bool isActive;
  final VoidCallback? onTap;
  final List<Widget>? children; // Optional dropdown options

  const NavWidget({
    super.key,
    required this.icon,
    required this.name,
    this.onTap,
    this.isActive = false,
    this.children,
  });

  @override
  State<NavWidget> createState() => _NavWidgetState();
}

class _NavWidgetState extends State<NavWidget> {
  bool _isExpanded = false; // Track dropdown state

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (widget.children != null) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
            if (widget.onTap != null) widget.onTap!();
          },
          child: Container(
            margin:
                const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            width: 180,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.isActive
                  ? Theme.of(context).colorScheme.outline
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.icon,
                    spaceW10,
                    RobotoCondensed(
                      text: widget.name,
                      fontSize: 14,
                      fontWeight:
                          widget.isActive ? FontWeight.bold : FontWeight.normal,
                      textColor: Theme.of(context).colorScheme.surface,
                    ),
                  ],
                ),
                if (widget.children != null)
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.surface,
                  ),
              ],
            ),
          ),
        ),
        if (_isExpanded && widget.children != null)
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children!,
            ),
          ),
      ],
    );
  }
}
