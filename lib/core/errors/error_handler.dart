import 'package:get/get.dart';
import 'exceptions.dart';

class ErrorHandler {
  static void handleError(dynamic error) {
    String message = 'An unexpected error occurred';
    
    if (error is AppException) {
      message = error.message;
    } else if (error is Exception) {
      message = error.toString().replaceAll('Exception: ', '');
    }
    
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
    );
  }
  
  static void handleSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF388E3C),
      colorText: const Color(0xFFFFFFFF),
    );
  }
  
  static void handleWarning(String message) {
    Get.snackbar(
      'Warning',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFFF57C00),
      colorText: const Color(0xFFFFFFFF),
    );
  }
  
  static void handleInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF1976D2),
      colorText: const Color(0xFFFFFFFF),
    );
  }
}
