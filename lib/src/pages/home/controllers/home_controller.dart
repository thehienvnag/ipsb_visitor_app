import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/product_category.dart';

import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

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
}

final categories = [
  ProductCategory(name: 'Cà phê', imageUrl: 'assets/images/icon_coffee.png'),
  ProductCategory(name: 'Trà sữa', imageUrl: 'assets/images/icon_milktea.png'),
  ProductCategory(name: 'Mua sắm', imageUrl: 'assets/images/icon_shopping.png'),
  ProductCategory(
      name: 'Nhà hàng', imageUrl: 'assets/images/icon_restaurant.png'),
  ProductCategory(name: 'Xem phim', imageUrl: 'assets/images/icon_cinema.png'),
];
