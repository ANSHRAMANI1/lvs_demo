import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final String? flag;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        // Gradient border technique: outer gradient container acts as the border,
        // inner container provides the pale green fill.
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7ED321), Color(0xFF3A9900)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              )
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
        padding: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: flag != null ? 12 : 16,
            vertical: 7,
          ),
          decoration: isSelected
              ? BoxDecoration(
                  color: const Color(0xFFEFF9D6),
                  borderRadius: BorderRadius.circular(22),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (flag != null) ...[
                Text(flag!, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF1A1A1A)
                      : const Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
