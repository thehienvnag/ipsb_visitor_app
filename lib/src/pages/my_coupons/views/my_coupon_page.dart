import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/widgets/animate_wrapper.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/ticket_box.dart';
import 'package:ipsb_visitor_app/src/pages/my_coupons/controllers/my_coupon_controller.dart';
import 'package:ipsb_visitor_app/src/widgets/user_welcome.dart';

class MyCouponPage extends GetView<MyCouponController> {
  final dateTime = DateTime.now();
  final SharedStates sharedStates = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoggedIn = AuthServices.isLoggedIn();
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
                              text: "ALL",
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Tab(
                              text: "NEW",
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Tab(
                              text: "USED",
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Tab(
                              text: "EXPIRED",
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
                      _displayAllCoupon(listCoupon, 'All', context),
                      _displayAllCoupon(listCoupon, 'New', context),
                      _displayAllCoupon(listCoupon, 'Used', context),
                      _displayAllCoupon(listCoupon, 'Expired', context),
                    ],
                  );
                }))
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/images/empty.png",
                          width: 150,
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary),
                          onPressed: () {
                            sharedStates.showLoginBottomSheet();
                          },
                          child: Text(
                            "REDEEM COUPONS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: CustomBottombar(),
        ),
      );
    });
  }

  Widget _displayAllCoupon(
      List<CouponInUse> listCoupon, String status, BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    var coupons = [];
    switch (status) {
      case 'Used':
        coupons = listCoupon.where((e) => e.status == status).toList();
        break;
      case 'New':
        coupons = listCoupon
            .where((e) =>
                e.status == 'NotUsed' &&
                !controller.checkExpireCoupon(e.coupon))
            .toList();
        break;
      case 'Expired':
        coupons = listCoupon
            .where((e) =>
                e.status == 'NotUsed' && controller.checkExpireCoupon(e.coupon))
            .toList();
        break;
      default:
        coupons = listCoupon;
    }

    if (coupons.isEmpty) {
      return Container(
        child: Center(
            child: Text(
          "No coupon have been saved !",
          style: TextStyle(fontSize: 20),
        )),
      );
    }
    final width = MediaQuery.of(context).size.width;
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
                  width: width * 0.9,
                  imgUrl: coupon.imageUrl!,
                  storeName: coupon.store?.name,
                  name: coupon.name,
                  description: coupon.description,
                  amount: coupon.amount,
                  couponTypeId: coupon.couponTypeId,
                  expireDate: coupon.expireDate,
                )
              ]),
            ),
          );
        });
  }
}
