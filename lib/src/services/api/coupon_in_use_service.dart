import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ICouponInUseService {
  Future<Paging<CouponInUse>> getCouponInUseByVisitorId(int visitorId);
  Future<CouponInUse> createCouponInUse(CouponInUse couponInUse);
}

class CouponInUseService extends BaseService<CouponInUse> implements ICouponInUseService {
  @override
  String endpoint() {
    return Endpoints.couponsInUse;
  }

  @override
  CouponInUse fromJson(Map<String, dynamic> json) {
    return CouponInUse.fromJson(json);
  }

  @override
  Future<Paging<CouponInUse>> getCouponInUseByVisitorId(int visitorId) {
    return getPagingBase({
      'visitorId': visitorId.toString()
    });
  }

  @override
  Future<CouponInUse> createCouponInUse(CouponInUse couponInUse) {
    return postBase(couponInUse.toJson());
  }
}