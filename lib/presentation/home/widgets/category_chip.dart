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
        decoration: isSelected
            ? null
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
        // ClipRRect ensures gradient is hard-clipped to the pill shape
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: flag != null ? 12 : 16,
              vertical: 7,
            ),
            decoration: isSelected
                ? const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7ED321), Color(0xFF4CAF50)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  )
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (flag != null) ...[
                  Text(
                    flag!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
