import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';

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

class CouponDetailController extends GetxController {
  /// Get selected coupon
  var coupon_model = listCouponFinal[0].obs;
}
