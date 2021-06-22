import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/services/shared_data/shared_data.dart';

final listFloorPlanFinal = [
  FloorPlan(floorCode: "Chọn tầng", floorNumber: 0),
  FloorPlan(floorCode: "Tầng 1", floorNumber: 1),
  FloorPlan(floorCode: "Tầng 2", floorNumber: 2),
  FloorPlan(floorCode: "Tầng 3", floorNumber: 3),
  FloorPlan(floorCode: "Tầng 4", floorNumber: 4),
  FloorPlan(floorCode: "Tầng 5", floorNumber: 5),
  FloorPlan(floorCode: "Tầng 5", floorNumber: 6),
];

final listCouponFinal = [
  Coupon(
      id: 1,
      name: 'Trà sữa Phúc Long',
      description: 'Giảm 30% cho đơn 100k',
      code: 'Giảm 30%',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Coupon(
      id: 3,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 1 tặng 1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Coupon(
      id: 4,
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 50%',
      status: 'Mở cả ngày',
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png'),
  Coupon(
      id: 5,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 2 tặng 1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Coupon(
      id: 6,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Coupon(
      id: 7,
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      status: 'Mở cả ngày',
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png'),
];

final listStoreSearchFinal = [
  Store(
      id: 1,
      name: 'Phúc Long',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 2,
      name: 'Highlands Coffee',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '2',
      status: 'Mở cả ngày',
      imageUrl:
          'http://niie.edu.vn/wp-content/uploads/2017/09/highlands-coffee.jpg'),
  Store(
      id: 3,
      name: 'Bobapop',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '3',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(
      id: 4,
      name: 'Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png'),
  Store(
      id: 5,
      name: 'Bobapop',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '3',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(
      id: 6,
      name: 'Phúc Long',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 7,
      name: 'Gong Cha',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 8,
      name: 'Gong Cha',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 9,
      name: 'Gong Cha',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 10,
      name: 'Gong Cha',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '1',
      status: 'Mở cả ngày',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 11,
      name: 'Highlands Coffee',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '2',
      status: 'Mở cả ngày',
      imageUrl:
          'http://niie.edu.vn/wp-content/uploads/2017/09/highlands-coffee.jpg'),
  Store(
      id: 12,
      name: 'Bobapop',
      description: 'Trà ngon vì sức khỏe',
      floorPlanId: '3',
      status: 'Mở cả ngày',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
];

class HomeController extends GetxController {
  /// [searchValue] for home screen
  var searchValue = "".obs;

  /// Get list coupons random data
  var listCoupon = listCouponFinal.obs;

  /// Get list stores when search
  var listStore = listStoreSearchFinal.obs;

  /// Change search value with String [value]
  void changeSearchValue(String value) {
    searchValue.value = value;
    listStore.value = listStoreSearchFinal;
  }

  ///  List floor plan data
  var listFloorPlan = listFloorPlanFinal.obs;

  /// Get selected of floor
  var selectedFloor = listFloorPlanFinal[0].obs;

  /// Change selected of floor
  void changeSelectedFloor(FloorPlan? floor) {
    selectedFloor.value = floor!;
  }

  /// Shared data
  final SharedData sharedData = Get.find();
}
