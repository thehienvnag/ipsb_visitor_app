import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/widgets/animate_wrapper.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_bottom_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponPage extends GetView<MyCouponController> {
  final dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Center(
            child: Text(
              'Mã giảm giá',
              style: TextStyle(color: Colors.black),
            ),
          ),
          bottom: PreferredSize(
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
                      text: "ĐÃ DÙNG",
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Tab(
                      text: "ĐÃ HẾT HẠN",
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
          ),
        ),
        body: Container(child: Obx(() {
          final listCoupon = controller.listCouponInUse;
          return TabBarView(
            children: [
              _displayAllCoupon(listCoupon, context),
              _displayAllCoupon(listCoupon, context),
              _displayAllCoupon(listCoupon, context),
            ],
          );
        })),
        bottomNavigationBar: CustomBottombar(),
      ),
    );
  }

  Widget _displayAllCoupon(List<CouponInUse> allCoupon, BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    if (allCoupon.isEmpty) {
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
        itemCount: allCoupon.length,
        itemBuilder: (BuildContext buildContext, int index) {
          var couponInUse = allCoupon[index];
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
