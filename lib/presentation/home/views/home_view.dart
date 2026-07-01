import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/stream_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _TopBar(),
          _TabRow(controller: controller),
          _CategoryRow(controller: controller),
          Expanded(child: _FeedGrid(controller: controller)),
        ],
      ),
      bottomNavigationBar: Obx(() => HomeBottomNavBar(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.selectNav,
          )),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, trace) => Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: AppColors.primaryGradient,
                  ),
                  child: const Icon(Icons.live_tv_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
            const Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_rounded,
                      color: Color(0xFF333333), size: 26),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.liveRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabRow extends StatelessWidget {
  final HomeController controller;
  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedIndex = controller.selectedTabIndex.value;
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: Row(
          children: List.generate(controller.tabs.length, (i) {
            final isSelected = selectedIndex == i;
            return GestureDetector(
              onTap: () => controller.selectTab(i),
              child: Container(
                padding: EdgeInsets.only(
                  left: i == 0 ? 16 : 0,
                  right: 20,
                  top: 13,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  controller.tabs[i],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFF999999),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}

class _CategoryRow extends StatelessWidget {
  final HomeController controller;
  const _CategoryRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Capture reactive value here — itemBuilder is lazy and runs outside Obx scope
      final selectedCategory = controller.selectedCategory.value;
      return SizedBox(
        height: 48,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, i) {
            final cat = controller.categories[i];
            return CategoryChip(
              label: cat['label']!,
              flag: cat['flag'],
              isSelected: selectedCategory == cat['label'],
              onTap: () => controller.selectCategory(cat['label']!),
            );
          },
        ),
      );
    });
  }
}

class _FeedGrid extends StatelessWidget {
  final HomeController controller;
  const _FeedGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Snapshot all reactive values here — GridView.builder's itemBuilder
      // is lazy and runs outside the Obx tracking scope
      final isLoading = controller.isLoading.value;
      final items = controller.feedItems.toList();

      if (isLoading) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2.5),
        );
      }

      if (items.isEmpty) {
        return const Center(
          child: Text('No streams available', style: TextStyle(color: AppColors.textSecondary)),
        );
      }

      return RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: Colors.white,
        onRefresh: controller.loadFeed,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) => StreamCard(item: items[i]),
        ),
      );
    });
  }
}
