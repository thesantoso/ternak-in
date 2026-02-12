class AppConstants {
  // App Info
  static const String appName = 'Ternak In';
  static const String appVersion = '1.0.0';
  
  // API
  static const String baseUrl = 'https://api.ternakin.com';
  static const String apiVersion = '/api/v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyThemeMode = 'theme_mode';
  
  // Navigation
  static const String routeDashboard = '/dashboard';
  static const String routeAnalytics = '/analytics';
  static const String routeChat = '/chat';
  static const String routeProfile = '/profile';
}
