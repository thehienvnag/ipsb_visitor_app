import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/product.dart';

import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IProductService {
  Future<List<Product>> getProductsByStoreId(int storeId);
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
}
