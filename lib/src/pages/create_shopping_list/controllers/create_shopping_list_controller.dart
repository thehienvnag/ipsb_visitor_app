import 'package:bot_toast/bot_toast.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';

class CreateShoppingListController extends GetxController {
  final selectedBuilding = Building().obs;
  final IBuildingService buildingService = Get.find();
  final IShoppingListService _iShoppingListService = Get.find();

  final shoppingListName = "".obs;
  final shoppingListBuilding = 0.obs;
  final shoppingDate = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Building>> loadBuilding([String? search]) async {
    return buildingService.searchBuildings(search);
  }

  void setShoppingBuilding(Building? building) {
    if (building != null && building.id != null) {
      shoppingListBuilding.value = building.id!;
    } else {
      shoppingListBuilding.value = 0;
    }
  }

  void submitForm() async {
    if (shoppingListName.isEmpty) return;
    if (shoppingListBuilding.value == 0) return;
    if (shoppingDate.isEmpty) return;
    final data = {
      "name": shoppingListName.value,
      "buildingId": shoppingListBuilding.value,
      "shoppingDate": shoppingDate.value,
      "accountId": AuthServices.userLoggedIn.value.id,
    };
    final result = await _iShoppingListService.create(data);
    if (result != null) {
      BotToast.showText(text: "Successfully created shopping list");
      Get.back(result: true);
    }
  }
}
