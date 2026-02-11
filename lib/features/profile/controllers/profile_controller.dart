import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/utils/storage_service.dart';

class ProfileController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();
  
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final data = await _apiService.getUserProfile();
      user.value = data;
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void editProfile() {
    Get.snackbar(
      'Edit Profile',
      'Profile editing feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void changePassword() {
    Get.snackbar(
      'Change Password',
      'Password change feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleNotifications() {
    ErrorHandler.handleInfo('Notifications toggled');
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () async {
        await _storageService.clear();
        Get.back();
        ErrorHandler.handleSuccess('Logged out successfully');
      },
    );
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}
