import 'package:get/get.dart';
import '../../../data/models/analytics_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/errors/error_handler.dart';

class AnalyticsController extends GetxController {
  final ApiService _apiService = Get.find();
  
  final RxList<AnalyticsDataModel> analyticsList = <AnalyticsDataModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedPeriod = 'Monthly'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalyticsData();
  }

  Future<void> loadAnalyticsData() async {
    try {
      isLoading.value = true;
      final data = await _apiService.getAnalyticsData();
      analyticsList.value = data;
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setPeriod(String period) {
    selectedPeriod.value = period;
    loadAnalyticsData();
  }

  Future<void> refresh() async {
    await loadAnalyticsData();
  }
}
