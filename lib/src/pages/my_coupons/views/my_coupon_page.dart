import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/widgets/animate_wrapper.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_bottom_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/user_welcome.dart';

class MyCouponPage extends GetView<MyCouponController> {
  final dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SharedStates sharedStates = Get.find();
    bool isLoggedIn = sharedStates.user != null;
    return DefaultTabController(
      length: isLoggedIn ? 4 : 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 40),
              child: Text(
                'MY COUPONS',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15, top: 5),
              child: ProfileIcon(),
            )
          ],
          bottom: isLoggedIn
              ? PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: TabBar(
                      indicatorColor: Colors.green,
                      tabs: [
                        Container(
                          width: 100,
                          child: Tab(
                            text: "TẤT CẢ",
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Tab(
                            text: "MỚI",
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Tab(
                            text: "ĐÃ DÙNG",
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Tab(
                            text: "HẾT HẠN",
                          ),
                        ),
                      ],
                      labelColor: Colors.black,
                      indicator: MaterialIndicator(
                        height: 5,
                        topLeftRadius: 8,
                        topRightRadius: 8,
                        horizontalPadding: 15,
                        tabPosition: TabPosition.bottom,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        body: isLoggedIn
            ? Container(child: Obx(() {
                final listCoupon = controller.listCouponInUse;
                return TabBarView(
                  children: [
                    _displayAllCoupon(listCoupon, 'All'),
                    _displayAllCoupon(listCoupon, 'New'),
                    _displayAllCoupon(listCoupon, 'Used'),
                    _displayAllCoupon(listCoupon, 'Expired'),
                  ],
                );
              }))
            : Container(
                child: Center(
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      sharedStates.showLoginBottomSheet();
                    },
                    child: Text(
                      "LOGIN TO REDEEM COUPONS!",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: CustomBottombar(),
      ),
    );
  }

  Widget _displayAllCoupon(List<CouponInUse> listCoupon, String status) {
    // final screenSize = MediaQuery.of(context).size;
    var coupons = [];
    switch (status) {
      case 'Used':
        coupons = listCoupon.where((e) => e.status == status).toList();

        break;
      case 'New':
        coupons = listCoupon
            .where((e) =>
                e.status == status && !controller.checkExpireCoupon(e.coupon))
            .toList();
        break;
      case 'Expired':
        coupons = listCoupon
            .where((e) => controller.checkExpireCoupon(e.coupon))
            .toList();
        break;
      default:
        coupons = listCoupon;
    }

    if (coupons.isEmpty) {
      return Container(
        child: Center(
            child: Text(
          "Chưa lưu voucher nào !",
          style: TextStyle(fontSize: 20),
        )),
      );
    }
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (BuildContext buildContext, int index) {
          var couponInUse = coupons[index];
          var coupon = couponInUse.coupon!;
          return GestureDetector(
            onTap: () => controller.gotoCouponDetails(couponInUse),
            child: AnimateWrapper(
              index: index,
              child: Column(children: [
                SizedBox(height: 15),
                TicketBox.small(
                  imgUrl: coupon.imageUrl!,
                  storeName: coupon.store?.name,
                  name: coupon.name,
                  description: coupon.description,
                  amount: coupon.amount,
                  discountType: coupon.discountType,
                  expireDate: coupon.expireDate,
                )
              ]),
            ),
          );
        });
  }
}
