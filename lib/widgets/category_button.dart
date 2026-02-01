import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: _getBorderColor(),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _getBoxShadow(),
            gradient: _getGradient(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.category != 'All') 
                Icon(
                  _getCategoryIcon(),
                  size: 16,
                  color: _getIconColor(),
                ),
              if (widget.category != 'All') SizedBox(width: 8),
              Text(
                widget.category,
                style: TextStyle(
                  color: _getTextColor(),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (widget.isSelected) {
      return Color(0xFFC67C4E);
    } else if (_isHovered) {
      return Color(0xFFC67C4E).withOpacity(0.08);
    } else {
      return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (widget.isSelected) {
      return Colors.white;
    } else if (_isHovered) {
      return Color(0xFFC67C4E);
    } else {
      return Colors.grey[700]!;
    }
  }

  Color _getIconColor() {
    if (widget.isSelected) {
      return Colors.white;
    } else if (_isHovered) {
      return Color(0xFFC67C4E);
    } else {
      return Colors.grey[600]!;
    }
  }

  Color _getBorderColor() {
    if (widget.isSelected) {
      return Color(0xFFC67C4E);
    } else if (_isHovered) {
      return Color(0xFFC67C4E).withOpacity(0.6);
    } else {
      return Colors.grey[300]!;
    }
  }

  List<BoxShadow> _getBoxShadow() {
    if (widget.isSelected) {
      return [
        BoxShadow(
          color: Color(0xFFC67C4E).withOpacity(0.3),
          blurRadius: 10,
          offset: Offset(0, 3),
          spreadRadius: 1,
        ),
      ];
    } else if (_isHovered) {
      return [
        BoxShadow(
          color: Color(0xFFC67C4E).withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 2),
          spreadRadius: 0.5,
        ),
      ];
    } else {
      return [];
    }
  }

  Gradient? _getGradient() {
    if (widget.isSelected) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFC67C4E),
          Color(0xFFD88A5C),
        ],
      );
    }
    return null;
  }

  IconData _getCategoryIcon() {
    switch (widget.category) {
      case 'Cappuccino':
        return Icons.coffee;
      case 'Latte':
        return Icons.local_cafe;
      case 'Espresso':
        return Icons.battery_charging_full;
      case 'Americano':
        return Icons.water_drop;
      default:
        return Icons.coffee_maker;
    }
  }
}