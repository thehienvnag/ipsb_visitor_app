import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';

final listCouponFinal = [
  CouponInUse(
      id: 1,
      name: 'Trà sữa Phúc Long',
      description: 'Giảm 30% cho đơn 100k',
      code: 'Giảm 30%',
      status: 'NotUse',
      imageUrl: 'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),
  CouponInUse(
      id: 3,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 1 tặng 1',
      status: 'NotUse',
      imageUrl: 'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),
  CouponInUse(
      id: 4,
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 50%',
      status: 'Expired',
      imageUrl: 'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),
  CouponInUse(
      id: 8,
      name: 'Trà sữa Tocotoco',
      description: 'Giảm giá cuối tuần',
      code: 'Giảm 20%',
      status: 'NotUse',
      imageUrl: 'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),
  CouponInUse(
      id: 5,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Mua 2 tặng 1',
      status: 'Used',
      imageUrl: 'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1',
      applyDate: '2022/10/11'
  ),
  CouponInUse(
      id: 6,
      name: 'Trà sữa Bobapop',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      status: 'NotUse',
      imageUrl: 'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),
  CouponInUse(
      id: 7,
      name: 'Trà sữa Tocotoco',
      description: 'Trà ngon vì sức khỏe',
      code: 'Giảm 20%',
      status: 'NotUse',
      imageUrl: 'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png',
      expireDate: '2022/10/15',
      publishDate: '2022/10/1'
  ),

];
class MyCouponController extends GetxController {
  /// Get selected coupon
  var coupon_model = listCouponFinal[0].obs;
  /// Get list all coupon of visitor save before
  var listCoupon = listCouponFinal.obs;
}