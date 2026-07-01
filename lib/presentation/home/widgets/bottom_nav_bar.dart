import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

// Geometry constants shared between painter and layout
const double _barH = 68;
const double _circleD = 52;
const double _notchR = 32;   // gives a 4px gap around the 26px-radius circle
const double _cornerR = 20;
const double _protrusion = _circleD / 2; // 26px above bar top
const double _totalH = _barH + _protrusion; // 94px

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
      height: _totalH,
      child: Stack(
        children: [
          // ── Green bar with rounded top corners + centre notch ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: _barH,
              width: double.infinity,
              child: CustomPaint(painter: _NavBarPainter()),
            ),
          ),

          // ── Four nav items (left two + right two, centre left empty) ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: _barH,
              child: Row(
                children: [
                  _NavItem(icon: Icons.home_rounded,        label: 'Home',    index: 0, selectedIndex: selectedIndex, onTap: onTap),
                  _NavItem(icon: Icons.celebration_rounded,  label: 'Party',   index: 1, selectedIndex: selectedIndex, onTap: onTap),
                  const Expanded(child: SizedBox()), // notch space
                  _NavItem(icon: Icons.send_rounded,         label: 'Chats',   index: 3, selectedIndex: selectedIndex, onTap: onTap),
                  _NavItem(icon: Icons.person_rounded,       label: 'Profile', index: 4, selectedIndex: selectedIndex, onTap: onTap),
                ],
              ),
            ),
          ),

          // ── "Go Live" label centred at same baseline as other labels ──
          Positioned(
            bottom: 9,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                child: const Text(
                  'Go Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // ── Go Live circle sitting in the notch ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Container(
                  width: _circleD,
                  height: _circleD,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE8E8E8), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints the green gradient bar with rounded top corners and a smooth
/// circular notch drawn manually for clean rendering on all GPU paths.
class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: const [Color(0xFF96D400), Color(0xFF28A800)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    const cR = _cornerR;
    const nR = _notchR;

    // Trace bar boundary clockwise starting from bottom-left.
    final path = Path()
      // bottom-left → bottom-right
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      // bottom-right → top-right (right side up)
      ..lineTo(size.width, cR)
      // top-right rounded corner
      ..arcToPoint(Offset(size.width - cR, 0),
          radius: const Radius.circular(cR), clockwise: false)
      // top edge right → notch entry
      ..lineTo(cx + nR, 0)
      // notch arc: from right entry, curves DOWN then back up to left entry
      // clockwise=false in Flutter (Y-down) = arc goes downward
      ..arcToPoint(Offset(cx - nR, 0),
          radius: const Radius.circular(nR), clockwise: false)
      // notch exit → top edge left
      ..lineTo(cR, 0)
      // top-left rounded corner
      ..arcToPoint(Offset(0, cR),
          radius: const Radius.circular(cR), clockwise: false)
      // left side down → close
      ..lineTo(0, size.height);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
            Icon(icon, size: 22, color: isSelected ? Colors.white : Colors.white70),
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
