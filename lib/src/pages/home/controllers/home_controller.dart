import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';

final listFloorPlanFinal = [
  Floor(name: "Chọn tầng", floorNum: 0),
  Floor(name: "Tầng 1", floorNum: 1),
  Floor(name: "Tầng 2", floorNum: 2),
  Floor(name: "Tầng 3", floorNum: 3),
  Floor(name: "Tầng 4", floorNum: 4),
  Floor(name: "Tầng 5", floorNum: 5),
  Floor(name: "Tầng 5", floorNum: 6),
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
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 2,
      name: 'Highlands Coffee',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '2',
      status: 'Mở cả ngày',
      image:
      'http://niie.edu.vn/wp-content/uploads/2017/09/highlands-coffee.jpg'),
  Store(
      id: 3,
      name: 'Bobapop',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '3',
      status: 'Mở cả ngày',
      image:
      'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(
      id: 4,
      name: 'Tocotoco',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png'),
  Store(
      id: 5,
      name: 'Bobapop',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '3',
      status: 'Mở cả ngày',
      image:
      'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(
      id: 6,
      name: 'Phúc Long',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 7,
      name: 'Gong Cha',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 8,
      name: 'Gong Cha',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 9,
      name: 'Gong Cha',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 10,
      name: 'Gong Cha',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '1',
      status: 'Mở cả ngày',
      image:
      'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(
      id: 11,
      name: 'Highlands Coffee',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '2',
      status: 'Mở cả ngày',
      image:
      'http://niie.edu.vn/wp-content/uploads/2017/09/highlands-coffee.jpg'),
  Store(
      id: 12,
      name: 'Bobapop',
      des: 'Trà ngon vì sức khỏe',
      floorNum: '3',
      status: 'Mở cả ngày',
      image:
      'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
];

class HomeController extends GetxController {
  var counter = 0.obs;

  /// IncreaseCounter var
  void increaseCounter() {
    counter.value++;
  }

  /// [searchValue] for home screen
  var searchValue = "".obs;

  /// Change search value with String [value]
  void changeSearchValue(String value) {
    searchValue.value = value;
  }

  ///  List floor plan data
  var listFloorPlan = listFloorPlanFinal.obs;
  /// Get selected of floor
  var selectedFloor = listFloorPlanFinal[0].obs;
  /// Change selected of floor
  void changeSelectedFloor(Floor? floor){
    selectedFloor.value = floor!;
  }
  /// Get list coupons random data
  var listCoupon = listCouponFinal.obs;

  /// Get list stores when search
  var listStore = listStoreSearchFinal.obs;
}
