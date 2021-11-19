import 'package:bot_toast/bot_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:ipsb_visitor_app/src/services/api/store_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildingDetailController extends GetxController {
  IStoreService _storeService = Get.find();
  IBuildingService _buildingService = Get.find();

  /// Get list stores of building
  final listStore = <Store>[].obs;

  /// Building details
  final building = Building().obs;

  /// Get list Store from api by buildingID
  Future<void> getStore(String buildingId) async {
    final paging = await _storeService.getStoresByBuilding(int.parse(buildingId));
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

  void goToBuildingStoreDetails(int? id) {
    if (id != null) {
      Get.toNamed(Routes.buildingStore,
          parameters: {"buildingID": id.toString()});
    }
  }

  var currentAddress = "".obs;

  openMap() async {
    if (building.value.id == null) return;
    Position? pos;
    try {
      pos = await Geolocator.getCurrentPosition();
    } catch (e) {}
    if (pos != null) {
      final current = "${pos.latitude},${pos.longitude}";
      final dest = '${building.value.lat},${building.value.lng}';
      MapUtils.openMap(current, dest);
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

class MapUtils {
  MapUtils._();
  static Future<void> openMap(String currentLocation, String location) async {
    String googleUrl =
        'https://www.google.com/maps/dir/$currentLocation/$location';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      BotToast.showText(text: "Can not launch map!");
    }
  }
}
