import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:get/get.dart';

class CreateShoppingListController extends GetxController {
  final selectedBuilding = Building().obs;
  final IBuildingService buildingService = Get.find();

  Future<List<Building>> loadBuilding() async {
    return buildingService.getBuildings();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
