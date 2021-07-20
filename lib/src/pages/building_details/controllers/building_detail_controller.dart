import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';

class BuildingDetailController extends GetxController {
  IStoreService _storeService = Get.find();
  IBuildingService _buildingService = Get.find();

  /// Get list stores of building
  final listStore = <Store>[].obs;

  /// Building details
  final building = Building().obs;

  /// Get list Store from api by buildingID
  Future<void> getStore(String buildingId) async {
    final paging =
        await _storeService.getStoresByBuilding(int.parse(buildingId));
    listStore.value = paging.content!;
  }

  /// Get building details
  Future<void> getBuildingDetails(String buildingId) async {
    final result =
        await _buildingService.getBuildingById(int.parse(buildingId));
    if (result != null) {
      building.value = result;
    }
  }

  void goToStoreDetails(int? id) {
    if (id != null) {
      Get.toNamed(Routes.storeDetails, parameters: {"id": id.toString()});
    }
  }

  @override
  void onInit() {
    super.onInit();
    String? id = Get.parameters['id'];
    if (id != null) {
      getStore(id);
      getBuildingDetails(id);
    }
  }
}
