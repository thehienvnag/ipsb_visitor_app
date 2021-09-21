import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:get/get.dart';

class CreateShoppingListController extends GetxController {
  final selectedBuilding = Building().obs;
  final IBuildingService buildingService = Get.find();

  final shoppingListName = "".obs;
  final shoppingListBuilding = 0.obs;
  final shoppingDate = "".obs;

  Future<List<Building>> loadBuilding([String? search]) async {
    return buildingService.searchBuildings(search);
  }

  void setShoppingBuilding(Building? building) {
    if (building == null) shoppingListBuilding.value = 0;
    shoppingListBuilding.value = building!.id!;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
