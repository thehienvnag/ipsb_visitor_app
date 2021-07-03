import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';

class BuildingDetailController extends GetxController {
  IStoreService _storeService = Get.find();

  /// Get list stores of building
  final listStore = <Store>[].obs;

  /// Get list Store from api by buildingID
  Future<void> getStore() async {
    final paging = await _storeService.getStoresByBuilding(1);
    listStore.value = paging.content!;
  }

  @override
  void onInit() {
    super.onInit();
    getStore();
  }
}
