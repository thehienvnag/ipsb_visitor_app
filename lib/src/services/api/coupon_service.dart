import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/paging.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin ICouponService {
  Future<List<Coupon>> getCouponsByStoreId(int storeId);
  Future<Paging<Coupon>> getCoupons();
  Future<List<Coupon>> searchCoupons(String keySearch, String buildingId);
  Future<List<Coupon>> getCouponsByBuildingId(
    int storeId, {
    bool random = false,
  });
  Future<List<Coupon>> getCounponsByFloorPlanId(int floorPlanId);
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
        'checkLimit': 'true',
        'lowerExpireDate': DateTime.now().toString(),
        'isAll': 'true',
      },
    );
  }

  @override
  Future<Paging<Coupon>> getCoupons() async {
    return getPagingBase({
      'checkLimit': 'true',
      'isAll': 'true',
    });
  }

  @override
  Future<List<Coupon>> searchCoupons(
      String buildingId, String keySearch) async {
    var byName = getAllBase({
      "isAll": "true",
      "name": keySearch,
      "buildingId": buildingId,
      'checkLimit': 'true',
      'lowerExpireDate': DateTime.now().toString(),
      'status': 'Active',
    });
    var byDescription = getAllBase({
      "isAll": "true",
      "description": keySearch,
      "buildingId": buildingId,
      'checkLimit': 'true',
      'lowerExpireDate': DateTime.now().toString(),
      'status': 'Active',
    });
    var result = await Future.wait([byName, byDescription]);
    var list = result.expand((element) => element).toList();
    final ids = list.map((e) => e.id).toSet();
    list.retainWhere((x) => ids.remove(x.id));
    return list;
  }

  @override
  Future<List<Coupon>> getCouponsByBuildingId(
    int buildingId, {
    bool random = false,
  }) {
    final params = {
      'buildingId': buildingId.toString(),
    };
    if (random) {
      params.putIfAbsent("random", () => "true");
    }
    return getAllBase(params);
  }

  @override
  Future<List<Coupon>> getCounponsByFloorPlanId(int floorPlanId) {
    return getAllBase({
      "floorPlanId": floorPlanId.toString(),
      "isAll": "true",
    });
  }
}
