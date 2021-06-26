import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/pages/store_details/controllers/store_details_controller.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/utils/utils.dart';
import 'package:indoor_positioning_visitor/src/widgets/rounded_button.dart';
import 'package:indoor_positioning_visitor/src/widgets/animate_wrapper.dart';

class StoreDetailsPage extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Obx(() {
                var store = controller.store.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: Utils.resolveDecoImg(store.imageUrl),
                          ),
                        ),
                        Positioned(
                          top: 18,
                          left: 15,
                          child: RoundedButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 40,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            radius: 40,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Container(
                        margin: const EdgeInsets.only(left: 14, top: 10),
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          Formatter.shorten(store.name),
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 26),
                        ),
                      ),
                      title: Text(Formatter.shorten(store.description)),
                      subtitle: Row(
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
                  ],
                );
              }),
              Container(
                child: TabBar(
                  indicatorColor: Colors.green,
                  tabs: [
                    Container(
                      width: 100,
                      child: Tab(
                        text: "SẢN PHẨM",
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Tab(
                        text: "VÉ ƯU ĐÃI",
                      ),
                    ),
                  ],
                  labelColor: Colors.black,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    horizontalPadding: 50,
                    tabPosition: TabPosition.bottom,
                  ),
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
      ),
    );
  }

  Widget _buildProducts() {
    return Obx(() {
      final products = controller.listProduct;
      return AnimationLimiter(
        child: GridView.count(
          childAspectRatio: 4 / 6,
          crossAxisCount: 2,
          children: List.generate(
            products.length,
            (int index) {
              final product = products[index];
              return AnimateWrapper(
                index: index,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: Card(
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(product.imageUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              Formatter.shorten(product.name),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              Formatter.shorten(product.description),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 16),
                            child: Text(
                              Formatter.price(product.price),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildCoupons() {
    return Obx(() {
      final coupons = controller.listCoupon;
      return ListView.builder(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final coupon = coupons[index];
          return AnimateWrapper(
            index: index,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Color(0xffF5F5F7),
                child: ListTile(
                  leading: Image.network(
                    coupon.imageUrl ?? '',
                    width: 50,
                  ),
                  title: Text(Formatter.shorten(coupon.name)),
                  subtitle: Text(Formatter.shorten(coupon.description)),
                  trailing: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.local_activity),
                    label: Text('Chi tiết'),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
