import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../routes/app_routes.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showAppBar;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showAppBar = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? AppBar(
              backgroundColor: AppColors.bgApp.withOpacity(0.8),
              elevation: 0,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(color: Colors.transparent),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: actions,
              iconTheme: const IconThemeData(color: AppColors.textPrimary),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  height: 1,
                ),
              ),
            )
          : null,
      drawer: const _NavigationDrawer(),
      body: body,
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return Drawer(
      backgroundColor: AppColors.bgCard,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Text(
                      'WT',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Warin Traveler',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'General User',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DrawerItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'หน้าหลัก',
              route: AppRoutes.home,
              isSelected: currentRoute == AppRoutes.home || currentRoute.isEmpty || currentRoute == '/',
            ),
            _DrawerItem(
              icon: Icons.assignment_outlined,
              activeIcon: Icons.assignment_rounded,
              label: 'งานของฉัน',
              route: AppRoutes.tasks,
              isSelected: currentRoute == AppRoutes.tasks,
            ),
            _DrawerItem(
              icon: Icons.inventory_2_outlined,
              activeIcon: Icons.inventory_2_rounded,
              label: 'รายการสินค้า',
              route: AppRoutes.inventory,
              isSelected: currentRoute == AppRoutes.inventory,
            ),
            _DrawerItem(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart_rounded,
              label: 'รายงานสถิติ',
              route: AppRoutes.mixLayout,
              isSelected: currentRoute == AppRoutes.mixLayout,
            ),
            _DrawerItem(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'โปรไฟล์ผู้ใช้',
              route: AppRoutes.profile,
              isSelected: currentRoute == AppRoutes.profile,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final bool isSelected;

  const _DrawerItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        onTap: () {
          Get.back();
          if (!isSelected) {
            Get.offAllNamed(route);
          }
        },
        leading: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: isSelected ? AppColors.primary.withOpacity(0.08) : Colors.transparent,
      ),
    );
  }
}
