import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';

class ManageCouponController extends GetxController {
  final listCoupon = <Coupon>[].obs;
  @override
  void onInit() {
    super.onInit();
    listCoupon.value = coupons;
  }
}

final coupons = [
  Coupon(
    id: 1,
    name: 'THỬ PHINDI MỚI!',
    description:
        'Thêm 6.000/ly để đổi ly PhinDi tặng sang cỡ vừa hoặc 10.000/ly để đổi sang cỡ lớn',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 2,
    name: 'CHỌN FREEZE TRÀ XANH, NHẬN THẺ TẬN HƯỞNG!',
    description:
        'Thưởng thức sự kết hợp hoàn hảo giữa vị Trà Xanh Đậm Đà cùng những miếng Thạch Giòn Khó Cưỡng.',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 3,
    name: 'SỔ ƯU ĐÃI MỪNG 300 QUÁN',
    description:
        'Từ ngày 07/07/2019 đến ngày 21/07/2019 tại Highlands Coffee® toàn quốc.',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 4,
    name: 'GIẢM 30K ĐƠN TỪ 100K',
    description:
        'E-Voucher giảm giá 30k cho đơn hàng 100k khi thanh toán bằng Airpay QR hoặc BLE Scan & Pay',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 5,
    name: 'GIẢM 30K ĐƠN TỪ 100K',
    description:
        'E-Voucher giảm giá 30k cho đơn hàng 100k khi thanh toán bằng Airpay QR hoặc BLE Scan & Pay',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Coupon(
    id: 6,
    name: 'GIẢM 30K ĐƠN TỪ 100K',
    description:
        'E-Voucher giảm giá 30k cho đơn hàng 100k khi thanh toán bằng Airpay QR hoặc BLE Scan & Pay',
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
];
