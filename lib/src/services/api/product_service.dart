import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';

import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin IProductService {
  Future<Product?> getProductById(int id);
  Future<List<Product>> getProductsByStoreId(int storeId);
  Future<List<Product>> searchByBuildingId(int buildingId, [String? search]);
}

class ProductService extends BaseService<Product> implements IProductService {
  @override
  String endpoint() {
    return Endpoints.products;
  }

  @override
  Product fromJson(Map<String, dynamic> json) {
    return Product.fromJson(json);
  }

  @override
  Future<List<Product>> getProductsByStoreId(int storeId) {
    return getAllBase(
      {
        'storeId': storeId.toString(),
      },
    );
  }

  @override
  Future<List<Product>> searchByBuildingId(int buildingId, [String? search]) {
    final params = {
      "pageSize": "5",
      "buildingId": buildingId.toString(),
      "status": "Active",
    };
    if (search != null) {
      params.putIfAbsent("name", () => search);
      params.putIfAbsent("isAll", () => "true");
    }

    return getAllBase(params);
  }

  @override
  Future<Product?> getProductById(int id) {
    return getByIdBase(id);
  }
}
