import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/themes/app_theme.dart';
import 'core/utils/storage_service.dart';
import 'core/network/dio_client.dart';
import 'data/services/api_service.dart';
import 'features/dashboard/bindings/dashboard_binding.dart';
import 'features/analytics/bindings/analytics_binding.dart';
import 'features/chat/bindings/chat_binding.dart';
import 'features/profile/bindings/profile_binding.dart';
import 'routes/main_navigation_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await initDependencies();
  
  runApp(const MyApp());
}

Future<void> initDependencies() async {
  // Initialize Storage Service
  final storageService = StorageService();
  await storageService.init();
  Get.put(storageService);
  
  // Initialize Network Client
  Get.put(DioClient());
  
  // Initialize API Service
  Get.put(ApiService());
  
  // Initialize feature bindings
  DashboardBinding().dependencies();
  AnalyticsBinding().dependencies();
  ChatBinding().dependencies();
  ProfileBinding().dependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ternak In',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MainNavigationView(),
      defaultTransition: Transition.fade,
    );
  }
}
