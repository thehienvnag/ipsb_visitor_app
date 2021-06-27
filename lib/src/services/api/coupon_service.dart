import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ICouponService {
  Future<List<Coupon>> getCouponsByStoreId(int storeId);
  //Future<Coupon> createCoupon(Coupon coupon);
}

class CouponService extends BaseService<Coupon> implements ICouponService {
  @override
  String endpoint() {
    return Endpoints.coupons;
  }

  @override
  Coupon fromJson(Map<String, dynamic> json) {
    return Coupon.fromJson(json);
  }

  @override
  Future<List<Coupon>> getCouponsByStoreId(int storeId) {
    return getAllBase(
      {
        'storeId': storeId.toString(),
      },
    );
  }

  // @override
  // Future<Coupon> createCoupon(Coupon coupon) async {
  //   var image = await ImagePicker().getImage(source: ImageSource.gallery);
  //   return postWithOneFileBase(coupon.toJson(),(image?.path)!);
  // }
}
