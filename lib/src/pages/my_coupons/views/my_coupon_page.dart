import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
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
            'Mã giảm giá của tôi',
            style: TextStyle(color: Colors.black),
          )),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Tất cả',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Đã hết hạn',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Đã dùng',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        body: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Obx(() {
              final listCoupon = controller.listCouponInUse;
              return TabBarView(
                children: [
                  _displayAllCoupon(listCoupon, context, 'NotUse'),
                  _displayExpireCoupon(listCoupon, context),
                  _displayUsedCoupon(listCoupon, context, 'Used'),
                ],
              );
            })),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Color(0xff0DB5B4)),
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          selectedItemColor: Color(0xff0DB5B4),
          unselectedItemColor: Color(0xffC4C4C4),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'My Coupons',
              icon: Icon(
                Icons.view_list,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Messenges',
              icon: Icon(
                Icons.notifications_active,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayAllCoupon(
      List<CouponInUse> allCoupon, BuildContext context, String status) {
    final screenSize = MediaQuery.of(context).size;

    if (allCoupon.isEmpty) {
      return Container(
        child: Center(
            child: Text(
          "Chưa lưu voucher nào !",
          style: TextStyle(fontSize: 20),
        )),
      );
    }
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: allCoupon.length,
          itemBuilder: (BuildContext buildContext, int index) {
            var couponInUse = allCoupon[index];
            if (controller.checkCouponValid(status, couponInUse)) {
              var coupon = couponInUse.coupon!;
              return GestureDetector(
                onTap: () => controller.gotoCouponDetails(couponInUse),
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
              );
            }
            return SizedBox();
          }),
    );
  }

  Widget _displayExpireCoupon(
      List<CouponInUse> allCoupon, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: allCoupon.length,
          itemBuilder: (BuildContext buildContext, int index) {
            final couponInUse = allCoupon[index];
            final coupon = couponInUse.coupon!;
            if (controller.checkExpireCoupon(coupon)) {
              return GestureDetector(
                onTap: () => controller.gotoCouponDetails(couponInUse),
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
              );
            }
            return SizedBox();
          }),
    );
  }

  Widget _displayUsedCoupon(
      List<CouponInUse> allCoupon, BuildContext context, String status) {
    final screenSize = MediaQuery.of(context).size;

    if (allCoupon.isEmpty) {
      return Container(
        child: Center(
            child: Text(
          "Chưa dùng voucher nào!",
          style: TextStyle(fontSize: 20),
        )),
      );
    }
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: allCoupon.length,
          itemBuilder: (BuildContext buildContext, int index) {
            var couponInUse = allCoupon[index];
            if (couponInUse.status == status) {
              var coupon = couponInUse.coupon!;
              return GestureDetector(
                onTap: () => controller.gotoCouponDetails(couponInUse),
                child: Column(children: [
                  SizedBox(height: 15),
                  TicketBox(
                      fromEdgeMain: 62,
                      fromEdgeSeparator: 134,
                      isOvalSeparator: false,
                      smallClipRadius: 15,
                      clipRadius: 25,
                      numberOfSmallClips: 8,
                      ticketWidth: 360,
                      ticketHeight: 130,
                      child: TicketBox.small(
                        imgUrl: coupon.imageUrl!,
                        storeName: coupon.store?.name,
                        name: coupon.name,
                        description: coupon.description,
                        amount: coupon.amount,
                        discountType: coupon.discountType,
                        expireDate: coupon.expireDate,
                      )),
                ]),
              );
            }
            return SizedBox();
          }),
    );
  }
}
