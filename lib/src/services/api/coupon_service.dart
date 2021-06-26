import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/controllers/store_details_controller.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ICouponService {
  Future<List<Coupon>> getCouponsByStoreId(int storeId);
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
}
