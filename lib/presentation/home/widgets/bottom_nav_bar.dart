import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

// Total height = circle_protrusion (28px) + green_bar (62px) = 90px
// Circle (56px) centered at the top edge of the green bar.
const double _barHeight = 62;
const double _circleSize = 56;
const double _protrusion = _circleSize / 2; // 28px above green bar
const double _totalHeight = _barHeight + _protrusion; // 90px

class HomeBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Green gradient bar — occupies the BOTTOM _barHeight pixels
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _barHeight,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Row(
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                  _NavItem(
                    icon: Icons.celebration_rounded,
                    label: 'Party',
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                  // Centre slot kept empty — Go Live circle is above via Positioned
                  const Expanded(child: SizedBox()),
                  _NavItem(
                    icon: Icons.send_rounded,
                    label: 'Chats',
                    index: 3,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                  _NavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    index: 4,
                    selectedIndex: selectedIndex,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ),

          // Go Live — circle centre sits exactly at the top edge of the green bar
          Positioned(
            top: 0,   // circle starts at y=0 in the 90px SizedBox
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: _circleSize,
                      height: _circleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.sensors_rounded,
                        color: AppColors.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Go Live',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
