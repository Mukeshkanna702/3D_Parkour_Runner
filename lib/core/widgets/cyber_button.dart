import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CyberButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isFilled;
  final double width;
  final double height;

  const CyberButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.isFilled = true,
    this.width = 240,
    this.height = 54,
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        transform: _isHovered ? Matrix4.diagonal3Values(1.04, 1.04, 1.0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: widget.isFilled
              ? (_isHovered ? AppColors.neonPink : AppColors.neonBlue)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isFilled ? Colors.transparent : AppColors.neonBlue,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isFilled
                  ? (_isHovered
                      ? AppColors.neonPink.withValues(alpha: 0.6)
                      : AppColors.neonBlue.withValues(alpha: 0.5))
                  : AppColors.neonBlue.withValues(alpha: 0.2),
              blurRadius: _isHovered ? 25 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.isFilled ? AppColors.bgPrimary : AppColors.neonBlue,
                  size: 20,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: widget.isFilled ? AppColors.bgPrimary : AppColors.neonBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
