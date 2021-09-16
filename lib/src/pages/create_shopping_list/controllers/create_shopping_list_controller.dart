import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';

class CreateShoppingListController extends GetxController {
  final buildings = <Building>[].obs;
  final selectedBuilding = Building().obs;
  final IBuildingService buildingService = Get.find();
  void loadBuilding() async {
    buildings.value = await buildingService.getBuildings();
  }
}
