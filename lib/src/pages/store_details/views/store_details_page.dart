import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';

import 'package:ipsb_visitor_app/src/pages/store_details/controllers/store_details_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';
import 'package:ipsb_visitor_app/src/widgets/animate_wrapper.dart';

class StoreDetailsPage extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: ScrollController(),
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  width: size.width,
                  child: Obx(() {
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
                                boxShadow: [AppBoxShadow.boxShadow],
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
                        Container(
                          margin: const EdgeInsets.only(left: 14, top: 20),
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
                        ListTile(
                          title: Text(Formatter.shorten(store.description)),
                          subtitle: Column(
                            children: [
                              Row(
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
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  controller: controller.tabController,
                  indicatorColor: Colors.green,
                  tabs: [
                    Container(
                      width: 100,
                      child: Tab(
                        text: "PRODUCTS",
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Tab(
                        text: "COUPONS",
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
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: [
              _buildProducts(context),
              _buildCoupons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProducts(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() {
        final products = controller.listProduct;
        return AnimationLimiter(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 4 / 6,
            crossAxisCount: 2,
            children: List.generate(
              products.length,
              (int index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => controller.gotoProductDetails(product.id),
                  child: AnimateWrapper(
                    index: index,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                      child: Card(
                        child: Container(
                          width: 200,
                          // padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 180,
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
                                  Formatter.shorten(product.name, 10),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  Formatter.price(product.price),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCoupons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Obx(() {
        final coupons = controller.listCoupon;
        return ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];
            return GestureDetector(
              onTap: () => controller.gotoCouponDetail(coupon),
              child: AnimateWrapper(
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
              ),
            );
          },
        );
      }),
    );
  }
}
