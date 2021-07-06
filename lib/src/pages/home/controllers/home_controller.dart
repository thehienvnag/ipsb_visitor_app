import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/product_category.dart';

import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';

class HomeController extends GetxController {
  IStoreService storeService = Get.find();
  ICouponService couponService = Get.find();
  IBuildingService buildingService = Get.find();
  final ScrollController scrollController = ScrollController();
  final showSlider = true.obs;
  final buildingId = 0.obs;
  final listStore = stores.obs;
  final listCoupon = coupons.obs;
  final listCategories = categories.obs;
  final buildings = [].obs;

  @override
  void onInit() {
    super.onInit();
    if (!initPage()) return;
    //getStores();
    //getCoupons();
  }

  bool initPage() {
    scrollController.addListener(() {
      final fromTop = scrollController.position.pixels;
      if (fromTop > 10) {
        showSlider.value = false;
      } else if (fromTop == 0) {
        showSlider.value = true;
      }
    });
    String? id = Get.parameters['id'];
    if (id == null) return false;
    buildingId.value = int.parse(id);
    return true;
  }

  void gotoDetails() {
    Get.toNamed(Routes.buildingDetails);
  }

  Future<void> getBuildings() async {
    final result = await buildingService.getBuildings();
    buildings.value = result;
  }

  Future<void> getStores() async {
    final stores = await storeService.getStoresByBuilding(buildingId.value);
    listStore.value = stores.content ?? [];
  }

  Future<void> getCoupons() async {
    listCoupon.value = await couponService.getCouponsByStoreId(18);
  }
}

final categories = [
  ProductCategory(name: 'Cà phê', imageUrl: 'assets/images/icon_coffee.png'),
  ProductCategory(name: 'Trà sữa', imageUrl: 'assets/images/icon_milktea.png'),
  ProductCategory(name: 'Mua sắm', imageUrl: 'assets/images/icon_shopping.png'),
  ProductCategory(name: 'Nhà hàng', imageUrl: 'assets/images/icon_restaurant.png'),
  ProductCategory(name: 'Xem phim', imageUrl: 'assets/images/icon_cinema.png'),
];

final stores = [
  Store(
    id: 1,
    name: 'Trung Nguyên Legend Cafe ',
    imageUrl:
        'https://printgo.vn/uploads/file-logo/1/512x512.00d1282ddc823f5e876c6258ff02d2f3.ai.1.png',
  ),
  Store(
    id: 2,
    name: 'The Pizza Company ',
    imageUrl:
        'http://static.ybox.vn/2019/3/2/1551761814432-1200px-The_Pizza_Company_Logo.svg.png',
  ),
  Store(
    id: 3,
    name: 'LOTTERIAL ',
    imageUrl:
        'https://uploads-ssl.webflow.com/5f2fe3ded95c7c53a081a285/5f55176a71709b6ffb4b29bf_2b3761_b52630ea7ff243d2af6c79297aa73cc9~mv2.png',
  ),
  Store(
    id: 4,
    name: 'Highlands Coffee ',
    imageUrl:
        'https://kalan-an.com/wp-content/uploads/2019/02/logo_kalan-an_highlands-coffee.jpg',
  ),
  Store(
    id: 5,
    name: 'The Body Shop ',
    imageUrl:
        'https://cloudfront.gotomalls.com/uploads/retailers/logo/L7VfeOvWvvJXxiYp-2288-the-body-shop-1422885122889802288_1.jpg',
  ),
  Store(
    id: 6,
    name: 'ADIDAS ',
    imageUrl:
        'https://img2.storyblok.com/filters:grayscale()/f/62481/500x500/e955841e5e/adidas-500x500-logo.jpg',
  ),
  Store(
    id: 7,
    name: 'Innisfree ',
    imageUrl:
        'https://bloganchoi.com/wp-content/uploads/2017/12/innisfree-logo-2.jpg',
  ),
  Store(
    id: 8,
    name: 'NIKE ',
    imageUrl:
        'https://i.pinimg.com/originals/41/e2/b6/41e2b604186c64d7604662d2234a2f99.jpg',
  ),
  Store(
    id: 8,
    name: 'KFC ',
    imageUrl:
        'https://gigamall.com.vn/data/2019/09/17/18124154_LOGO-KFC-500x500.jpg',
  ),
];

final coupons = [
  Coupon(
    store: Store(name: 'Highlands Coffee'),
    id: 1,
    description: 'Ưu đãi mua 1 tặng 1 vào ngày 7/7/2021',
    imageUrl:
        'https://vuakhuyenmai.vn/wp-content/uploads/2020/06/HIGHLAND-MUA-1-TANG-1-4720.jpg',
  ),
  Coupon(
    store: Store(name: 'LOTTERIAL'),
    id: 3,
    description: 'Ưu đãi giảm 43% trên tổng hóa đơn 500k',
    imageUrl:
        'https://img.kam.vn/images/414x0/92660d6d3dd1412495428b7bc8a45fc9/yes24-san-voucher-giam-den-43-tu-lotteria.jpg',
  ),
  Coupon(
    store: Store(name: 'Trung Nguyên Legend Cafe'),
    id: 2,
    description: 'Giảm 10k cà phê sáng và bánh mì',
    imageUrl:
        'https://img.kam.vn/images/375x0/475b76ba278e4668831a2ab5348f6ca2/image/trung-nguyen-e-coffee-giam-10k-khi-chon-mua-cung-banh-mi-op-la-hoac-banh-mi-ca-xot-ca.jpg',
  ),
  Coupon(
    store: Store(name: 'The Pizza Company'),
    id: 4,
    description: 'Mua 1 tặng 1 với giá chỉ 120k',
    imageUrl:
        'https://stc.shopiness.vn/deal/2017/08/30/1/3/3/a/1504077887275_540.png',
  ),
  Coupon(
    store: Store(name: 'The Body Shop'),
    id: 5,
    description: 'Gỉảm 20% và nhận quà 210k vào ngày 7/7/2021',
    imageUrl:
        'https://stc.shopiness.vn/deal/2019/03/28/9/3/6/4/1553765517157_540.png',
  ),
  Coupon(
    store: Store(name: 'The Coffee House'),
    id: 6,
    description: 'Mua 2 tặng 1 áp dụng với trà đào vị đào',
    imageUrl:
        'https://stc.shopiness.vn/deal/2021/03/17/8/3/7/7/1615964681763_540.png',
  ),
];
