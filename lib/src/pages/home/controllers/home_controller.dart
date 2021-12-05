import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/product_category.dart';

import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/api/notification_service.dart';
import 'package:ipsb_visitor_app/src/services/api/product_category_service.dart';
import 'package:ipsb_visitor_app/src/services/api/store_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';

class HomeController extends FullLifeCycleController {
  IStoreService storeService = Get.find();
  ICouponService couponService = Get.find();
  IBuildingService buildingService = Get.find();
  INotificationService _notificationService = Get.find();
  IProductCategoryService _categoryService = Get.find();
  final scrollController = ScrollController().obs;
  final showSlider = true.obs;
  final buildingId = 0.obs;
  final currentAddress = "".obs;
  final listCategories = <ProductCategory>[].obs; //categories.obs;

  final buildings = [].obs;

  /// Type of search
  final typeSearch = "Coupons".obs;

  /// Search loading
  final isSearching = false.obs;

  /// List search of coupons
  final listStoreSearch = <Store>[].obs;

  /// List search of coupons
  final listBuildingSearch = <Building>[].obs;

  /// List search of coupons
  final listSearchCoupons = <Coupon>[].obs;

  final listCoupon = <Coupon>[].obs;
  final listStore = <Store>[].obs;
  final listBuilding = <Building>[].obs;

  // Current position: Lat, Lng
  final Rx<Position?> pos = Rx<Position?>(null);

  final loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    try {
      pos.value = await Geolocator.getCurrentPosition();
    } catch (e) {}
    getBuildings();
    initPage();
    updateNotifications();
  }

  ScrollController initScrollController() {
    final scroll = ScrollController();
    scroll.addListener(() {
      final fromTop = scroll.position.pixels;
      if (fromTop > 10) {
        showSlider.value = false;
      } else if (fromTop == 0 && listCoupon.isNotEmpty) {
        showSlider.value = true;
      }
    });
    return scroll;
  }

  SharedStates states = Get.find();
  void initPage() async {
    await initBuilding();
    if (states.building.value.id == null) return;
    buildingId.value = states.building.value.id!;
    await Future.wait([
      getStores(),
      getCoupons(),
      getProductCategory(),
    ]);
    loading.value = false;
  }

  Future<void> initBuilding() async {
    if (pos.value?.latitude == null || pos.value?.longitude == null) return;
    final building = await buildingService.findCurrentBuilding(
      pos.value!.latitude,
      pos.value!.longitude,
    );
    if (building != null) {
      states.building.value = building;
    } else {
      states.building.value = Building();
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        pos.value!.latitude,
        pos.value!.latitude,
      );
      if (placeMarks.isNotEmpty) {
        final place = placeMarks.first;
        currentAddress.value = Formatter.formatAddress(place);
      } else {
        currentAddress.value = 'Location not found';
      }
    }
  }

  void updateNotifications() async {
    if (AuthServices.userLoggedIn.value.id != null) {
      states.unreadNotification.value =
          await _notificationService.countNotification({
        "status": Constants.unread,
        "accountId": AuthServices.userLoggedIn.value.id!.toString()
      });
    }
  }

  void gotoDetails([int? id]) {
    Get.toNamed(Routes.buildingDetails, parameters: {
      "id": id.toString(),
    });
  }

  void goToStoreDetails(int? id) {
    if (id != null) {
      Get.toNamed(Routes.storeDetails, parameters: {"id": id.toString()});
    }
  }

  void goToCouponDetails(Coupon coupon) {
    states.coupon.value = coupon;
    Get.toNamed(Routes.couponDetail, parameters: {
      'couponId': coupon.id.toString(),
    });
  }

  Future<void> getStores() async {
    if (buildingId.value == 0) return;
    final stores = await storeService.getStoresByBuilding(buildingId.value);
    listStore.value = stores.content ?? [];
  }

  Future<void> getCoupons() async {
    if (buildingId.value == 0) return;
    listCoupon.value = await couponService.getCouponsByBuildingId(
      buildingId.value,
      random: true,
    );
    if (listCoupon.isEmpty) {
      showSlider.value = false;
    }
  }

  Future<void> getBuildings() async {
    final list = await buildingService.getBuildings(
      pos.value?.latitude,
      pos.value?.longitude,
    );
    if (list.isNotEmpty &&
        list.first.distanceTo != null &&
        list.first.distanceTo! < 0.5) {
      list.removeAt(0);
    }
    listBuilding.value = list;
  }

  Future<void> search(String keySearch) async {
    if (keySearch.isEmpty) {
      listSearchCoupons.clear();
      listBuildingSearch.clear();
      listStoreSearch.clear();
      return;
    }

    if (!isSearching.value) {
      isSearching.value = true;
      if (typeSearch.value == "Coupons") {
        listSearchCoupons.value = await couponService.searchCoupons(
          keySearch,
          lat: pos.value!.latitude,
          lng: pos.value!.longitude,
        );
      } else if (typeSearch.value == "Buildings") {
        listBuildingSearch.value = await buildingService.searchBuildings(
          keySearch,
          pos.value!.latitude,
          pos.value!.longitude,
        );
      } else if (typeSearch.value == "Stores") {
        final stores = await storeService.searchStore(
          keySearch,
          lat: pos.value!.latitude,
          lng: pos.value!.longitude,
        );
        listStoreSearch.value = stores;
      }
      Timer(Duration(seconds: 1), () => isSearching.value = false);
    }
  }

  /// Get list ProductCategory by api
  Future<void> getProductCategory() async {
    final paging = await _categoryService.getProductCategory();
    listCategories.value = paging.content!;
  }

  void goToBuildingStoreDetails() {
    if (buildingId.value != 0) {
      Get.toNamed(Routes.buildingStore,
          parameters: {"buildingID": buildingId.value.toString()});
    }
  }
}
