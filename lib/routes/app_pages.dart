import 'package:get/get.dart';
import '../features/dashboard/views/dashboard_view.dart';
import '../features/dashboard/bindings/dashboard_binding.dart';
import '../features/analytics/views/analytics_view.dart';
import '../features/analytics/bindings/analytics_binding.dart';
import '../features/chat/views/chat_view.dart';
import '../features/chat/bindings/chat_binding.dart';
import '../features/profile/views/profile_view.dart';
import '../features/profile/bindings/profile_binding.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String analytics = '/analytics';
  static const String chat = '/chat';
  static const String profile = '/profile';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.analytics,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
