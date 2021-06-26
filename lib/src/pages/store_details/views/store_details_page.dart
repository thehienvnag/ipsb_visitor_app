import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';

import 'package:indoor_positioning_visitor/src/models/product.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/controllers/store_details_controller.dart';

class StoreDetailsPage extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Obx(() {
              var store = controller.store.value;
              return Column(
                children: [
                  Container(
                    child: Image.network(store.imageUrl ?? ''),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 220, top: 10),
                    child: Text(
                      store.name ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 90),
                    child: Text(store.description ?? ''),
                  ),
                ],
              );
            }),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff0DB5B4),
                    ),
                  ),
                  Text('Tầng 1 - Vincom Lê Văn Việt'),
                ],
              ),
            ),
            // Divider(
            //   height: 10,
            //   thickness: 2,
            // ),
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Sản phẩm',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Vé ưu đãi',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProducts(),
                  _buildCoupons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProducts() {
    return Obx(() {
      final products = controller.listProduct;
      return ListView.separated(
        itemBuilder: (context, index) {
          Product product = products[index];
          return Row(
            children: [
              Image.network(
                product.imageUrl ?? '',
                height: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 42, bottom: 5),
                        child: Text(product.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        child: Text(
                          '${product.price} VNĐ',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      product.description ?? '',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          indent: 30,
          endIndent: 30,
          color: Colors.black,
        ),
        itemCount: products.length,
      );
    });
  }

  Widget _buildCoupons() {
    return Obx(() {
      final coupons = controller.listCoupon;
      return ListView.separated(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final coupon = coupons[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                coupon.imageUrl ?? '',
                height: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    width: 240,
                    child: Text(coupon.name ?? '',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    width: 240,
                    child: Text(
                      coupon.description ?? '',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.info),
                    label: Text('Xem chi tiết'),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          indent: 30,
          endIndent: 30,
          color: Colors.black,
        ),
      );
    });
  }
}
