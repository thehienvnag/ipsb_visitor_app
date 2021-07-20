import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ICouponService {
  Future<List<Coupon>> getCouponsByStoreId(int storeId);
  Future<Paging<Coupon>> getCoupons();
  Future<List<Coupon>> searchCoupons(String keySearch, String buildingId);
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

  @override
  Future<Paging<Coupon>> getCoupons() async {
    return getPagingBase({});
  }

  @override
  Future<List<Coupon>> searchCoupons(
      String buildingId, String keySearch) async {
    var byName = getAllBase({
      "isAll": "true",
      "name": keySearch,
      "buildingId": buildingId,
    });
    var byDescription = getAllBase({
      "isAll": "true",
      "description": keySearch,
      "buildingId": buildingId,
    });
    var result = await Future.wait([byName, byDescription]);
    var list = result.expand((element) => element).toList();
    final ids = list.map((e) => e.id).toSet();
    list.retainWhere((x) => ids.remove(x.id));
    return list;
  }
}
