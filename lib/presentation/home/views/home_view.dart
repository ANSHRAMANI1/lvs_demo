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
                // Gray circle background
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFF888888),
                      size: 24,
                    ),
                  ),
                ),
                // Red badge
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.red,
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
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
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
      return Row(
          children: List.generate(controller.tabs.length, (i) {
            final isSelected = selectedIndex == i;
            return GestureDetector(
              onTap: () => controller.selectTab(i),
              child: Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 16 : 0,
                  right: 22,
                  top: 12,
                  bottom: 12,
                ),
                child: Text(
                  controller.tabs[i],
                  style: TextStyle(
                    fontSize: isSelected ? 17 : 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFAAAAAA),
                  ),
                ),
              ),
            );
          }),
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
        height: 52,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
