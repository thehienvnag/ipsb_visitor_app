import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

final dateTime = DateTime.now();

final listCouponFinal = [
  CouponInUse(
    id: 1,
    status: 'Active',
    coupon: Coupon(
      name: 'Trà sữa Phúc Long',
      description: 'Giảm 30% cho đơn 100k',
      code: 'Giảm 30%',
      imageUrl:
          'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg',
      expireDate: dateTime,
      publishDate: dateTime,
    ),
  ),
  CouponInUse(
    id: 3,
    status: 'Active',
    coupon: Coupon(
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: dateTime,
      publishDate: dateTime,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 1 tặng 1',
    ),
  ),
  CouponInUse(
    id: 4,
    status: 'Inactive',
    coupon: Coupon(
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: dateTime,
      publishDate: dateTime,
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 50%',
    ),
  ),
  CouponInUse(
    id: 8,
    status: 'Inactive',
    coupon: Coupon(
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: dateTime,
      publishDate: dateTime,
      name: 'Trà sữa Tocotoco',
      description: 'Giảm giá cuối tuần',
      code: 'Giảm 20%',
    ),
  ),
  CouponInUse(
    id: 5,
    applyDate: dateTime,
    status: 'Inactive',
    coupon: Coupon(
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: dateTime,
      publishDate: dateTime,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 2 tặng 1',
    ),
  ),
  CouponInUse(
    id: 6,
    status: 'Active',
    coupon: Coupon(
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      imageUrl:
          'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: dateTime,
      publishDate: dateTime,
    ),
  ),
  CouponInUse(
    id: 7,
    status: 'Active',
    coupon: Coupon(
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      imageUrl:
          'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: dateTime,
      publishDate: dateTime,
    ),
  ),
];

class MyCouponController extends GetxController {
  /// Shared data
  final SharedStates sharedData = Get.find();

  /// Get list all coupon of visitor save before
  var listCoupon = listCouponFinal.obs;

  void gotoCouponDetails(CouponInUse coupon) {
    sharedData.saveCouponInUse(coupon);
    Get.toNamed(Routes.couponDetail);
  }
}
