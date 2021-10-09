import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/product_category.dart';

import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/api/store_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  IStoreService storeService = Get.find();
  final ScrollController scrollController = ScrollController();
  final showSlider = true.obs;
  final buildingId = 0.obs;
  final buildingName = "".obs;
  final listCategories = categories.obs;
  final buildings = [].obs;
  final listCoupon = <Coupon>[].obs;
  final listStore = <Store>[].obs;
  final listBuilding = <Building>[].obs;
  @override
  void onInit() {
    super.onInit();
    if (!initPage()) return;
    initPage();
    getStores();
    getCoupons();
    getBuildings();
  }

  SharedStates states = Get.find();
  bool initPage() {
    scrollController.addListener(() {
      final fromTop = scrollController.position.pixels;
      if (fromTop > 10) {
        showSlider.value = false;
      } else if (fromTop == 0) {
        showSlider.value = true;
      }
    });
    buildingId.value = states.building.value.id!;
    buildingName.value = states.building.value.name!;
    return true;
  }

  void gotoDetails([int? id]) {
    Get.toNamed(Routes.buildingDetails, parameters: {
      "id": id != null ? id.toString() : buildingId.value.toString()
    });
  }

  void goToStoreDetails(int? id) {
    if (id != null) {
      Get.toNamed(Routes.storeDetails, parameters: {"id": id.toString()});
    }
  }

  void goToCouponDetails(Coupon coupon) {
    states.coupon.value = coupon;
    // states.couponInUse.value = coupon;
    Get.toNamed(Routes.couponDetail, parameters: {
      'couponId': coupon.id.toString(),
    });
  }

  Future<void> getStores() async {
    final stores = await storeService.getStoresByBuilding(buildingId.value);
    listStore.value = stores.content ?? [];
  }

  ICouponService couponService = Get.find();
  Future<void> getCoupons() async {
    listCoupon.value = (await couponService.getCoupons()).content ?? [];
  }

  IBuildingService buildingService = Get.find();
  Future<void> getBuildings() async {
    listBuilding.value = (await buildingService.getBuildings());
  }

  final listSearchCoupons = <Coupon>[].obs;
  final isSearching = false.obs;
  Future<void> searchCoupons(String keySearch) async {
    if (keySearch.isEmpty) {
      listSearchCoupons.clear();
      return;
    }
    int? bId = buildingId.value;

    if (!isSearching.value) {
      isSearching.value = true;
      listSearchCoupons.value =
          await couponService.searchCoupons(bId.toString(), keySearch);
      Timer(Duration(seconds: 1), () => isSearching.value = false);
    }
  }

  var distanceTwoPoin = "".obs;

  // Future<String> getDistanceBetweenTwoLocation(String buildingAddress) async {
  //   Location location = new Location();
  //   GeoCode geoCode = GeoCode();
  //   LocationData myLocation;
  //   myLocation = await location.getLocation();
  //   Coordinates coordinates =
  //       await geoCode.forwardGeocoding(address: buildingAddress);
  //   double distance = Geolocator.distanceBetween(
  //       myLocation.latitude!.toDouble(),
  //       myLocation.longitude!.toDouble(),
  //       coordinates.latitude!.toDouble(),
  //       coordinates.longitude!.toDouble());
  //   final formatter = new NumberFormat("###,###,###,###");
  //   distanceTwoPoin.value = formatter.format(distance / 1000) + ' Km';
  //   print("nè nè : " + formatter.format(distance / 1000) + ' Km');
  //   return formatter.format(distance / 1000) + ' Km';
  // }

  // String getDistanceDisplay(String address) {
  //   var valueDistan = "";
  //   getDistanceBetweenTwoLocation(address).then((value) {
  //     valueDistan = value;
  //   });
  //   print("hello: " + valueDistan);
  //   return valueDistan;
  // }
}

final categories = [
  ProductCategory(name: 'Cà phê', imageUrl: 'assets/images/icon_coffee.png'),
  ProductCategory(name: 'Trà sữa', imageUrl: 'assets/images/icon_milktea.png'),
  ProductCategory(name: 'Mua sắm', imageUrl: 'assets/images/icon_shopping.png'),
  ProductCategory(
      name: 'Nhà hàng', imageUrl: 'assets/images/icon_restaurant.png'),
  ProductCategory(name: 'Xem phim', imageUrl: 'assets/images/icon_cinema.png'),
];
