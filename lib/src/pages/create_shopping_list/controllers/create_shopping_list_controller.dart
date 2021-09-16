import 'package:visitor_app/src/models/building.dart';
import 'package:visitor_app/src/services/api/building_service.dart';
import 'package:get/get.dart';

class CreateShoppingListController extends GetxController {
  final buildings = <Building>[].obs;
  final selectedBuilding = Building().obs;
  final IBuildingService buildingService = Get.find();
  void loadBuilding() async {
    buildings.value = await buildingService.getBuildings();
  }
}
