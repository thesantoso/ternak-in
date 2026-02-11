import 'package:get/get.dart';
import '../../../data/models/livestock_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/errors/error_handler.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = Get.find();
  
  final RxList<LivestockModel> livestockList = <LivestockModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      final data = await _apiService.getLivestockData();
      livestockList.value = data;
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  List<LivestockModel> get filteredLivestock {
    if (selectedFilter.value == 'All') {
      return livestockList;
    }
    return livestockList
        .where((item) => item.type == selectedFilter.value)
        .toList();
  }

  int get totalCount {
    return livestockList.fold(0, (sum, item) => sum + item.count);
  }

  int get healthyCount {
    return livestockList
        .where((item) => item.health == 'Excellent' || item.health == 'Good')
        .fold(0, (sum, item) => sum + item.count);
  }

  Future<void> refresh() async {
    await loadDashboardData();
  }
}
