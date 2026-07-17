import 'package:get/get.dart';
import '../components/home_page.dart';
import '../components/task_page.dart';
import '../components/inventory_page.dart';
import '../components/mix_layout_page.dart';
import '../components/profile_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String inventory = '/inventory';
  static const String mixLayout = '/mixLayout';
  static const String profile = '/profile';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: tasks,
      page: () => const TaskPage(),
    ),
    GetPage(
      name: inventory,
      page: () => const InventoryPage(),
    ),
    GetPage(
      name: mixLayout,
      page: () => const MixLayoutPage(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
    ),
  ];
}
