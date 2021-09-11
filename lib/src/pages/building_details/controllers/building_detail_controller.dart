import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class BuildingDetailController extends GetxController {
  IStoreService _storeService = Get.find();
  IBuildingService _buildingService = Get.find();
  GeoCode geoCode = GeoCode();

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

  var currentAddress = "".obs;

  getUserLocation() async {
    Location location = new Location();

    LocationData myLocation;
    myLocation = await location.getLocation();
    // var addresses = await geoCode.reverseGeocoding(latitude: myLocation.latitude!.toDouble(), longitude: myLocation.longitude!.toDouble());
    // currentAddress.value = (addresses.streetAddress.toString() + " " + addresses.city.toString()+ " " + addresses.region.toString()+ " " + addresses.countryName.toString());
    // print('hello: '+ addresses.toString()+"/ địa chỉ nè : " + addresses.streetAddress.toString() + " " + addresses.city.toString()+ " " + addresses.region.toString()+ " " + addresses.countryName.toString());
  }

  // var distanceTwoPoin = "".obs;
  //
  // getDistanceBetweenTwoLocation(String buildingAddress) async {
  //   Location location = new Location();
  //   LocationData myLocation;
  //   myLocation = await location.getLocation();
  //   Coordinates coordinates = await geoCode.forwardGeocoding(address: buildingAddress);
  //   double distance = Geolocator.distanceBetween(
  //       myLocation.latitude!.toDouble(), myLocation.longitude!.toDouble(),
  //       coordinates.latitude!.toDouble(),coordinates.longitude!.toDouble());
  //   distanceTwoPoin.value = distance.toString();
  //   print("nè nè : " + (distance / 1000).toString());
  // }

  @override
  void onInit() {
    super.onInit();
    String? id = Get.parameters['id'];
    if (id != null) {
      getStore(id);
      getBuildingDetails(id);
    }
    getUserLocation();
  }
}

class MapUtils {
  MapUtils._();
  static Future<void> openMap(String currentLocation, String location) async {
    String googleUrl =
        'https://www.google.com/maps/dir/${currentLocation}/${location}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
