import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/dashboard/views/dashboard_view.dart';
import '../features/analytics/views/analytics_view.dart';
import '../features/chat/views/chat_view.dart';
import '../features/profile/views/profile_view.dart';
import 'main_navigation_controller.dart';

class MainNavigationView extends StatelessWidget {
  MainNavigationView({super.key});

  final MainNavigationController controller = Get.put(MainNavigationController());

  final List<Widget> _pages = [
    const DashboardView(),
    const AnalyticsView(),
    const ChatView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onFabPressed,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'Dashboard',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.analytics_outlined,
                selectedIcon: Icons.analytics,
                label: 'Analytics',
                index: 1,
              ),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(
                icon: Icons.chat_bubble_outline,
                selectedIcon: Icons.chat_bubble,
                label: 'Chat',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.changePage(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Icon(
              controller.currentIndex.value == index ? selectedIcon : icon,
              color: controller.currentIndex.value == index
                  ? Get.theme.primaryColor
                  : Colors.grey,
            )),
            const SizedBox(height: 4),
            Obx(() => Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: controller.currentIndex.value == index
                    ? Get.theme.primaryColor
                    : Colors.grey,
                fontWeight: controller.currentIndex.value == index
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
