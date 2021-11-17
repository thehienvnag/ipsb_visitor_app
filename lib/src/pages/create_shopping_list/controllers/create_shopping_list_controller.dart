import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
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
    if (shoppingListName.isEmpty) {
      BotToast.showText(
          text: "Input name shopping list",
          textStyle: TextStyle(fontSize: 16,color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    } else if (shoppingListBuilding.value == 0) {
      BotToast.showText(
          text: "Select building shopping!",
          textStyle: TextStyle(fontSize: 16,color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    } else if (shoppingDate.isEmpty){
      BotToast.showText(
          text: "Pick date shopping!",
          textStyle: TextStyle(fontSize: 16,color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    }
    else {
      BotToast.showLoading();
      final data = {
        "name": shoppingListName.value,
        "buildingId": shoppingListBuilding.value,
        "shoppingDate": shoppingDate.value,
        "accountId": AuthServices.userLoggedIn.value.id,
      };
      final result = await _iShoppingListService.create(data);
      BotToast.closeAllLoading();
      if (result != null) {
        BotToast.showText(text: "Successfully created shopping list");
        Get.back(result: true);
      }
    }
  }
}
