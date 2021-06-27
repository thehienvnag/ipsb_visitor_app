import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponPage extends GetView<MyCouponController> {
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
              final listCoupon = controller.listCoupon;
              return TabBarView(
                children: [
                  _displayAllCoupon(listCoupon, context, 'Active'),
                  _displayExpireCoupon(listCoupon, context, 'Active'),
                  _displayUsedCoupon(listCoupon, context, 'Active'),
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
            final coupon = couponInUse.coupon!;
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
                  ticketWidth: 340,
                  ticketHeight: 130,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              child: Image.network(
                                coupon.imageUrl ?? '',
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                screenSize.height * 0.8 ~/ (10 + 5),
                                (_) => Container(
                                  width: 2,
                                  height: 2,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  coupon.name ?? 'Name not set',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coupon.description ?? 'Description not set',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      coupon.code ?? 'Code not set',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('  Xem chi tiết',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 13)),
                                  ],
                                ),
                                Text(
                                  'Ngày hết hạn: ${Formatter.date(coupon.expireDate)}',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }),
    );
  }

  Widget _displayExpireCoupon(
      List<CouponInUse> allCoupon, BuildContext context, String status) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: allCoupon.length,
          itemBuilder: (BuildContext buildContext, int index) {
            final couponInUse = allCoupon[index];
            final coupon = couponInUse.coupon!;
            return GestureDetector(
              onTap: () {
                controller.sharedData.saveCouponInUse(couponInUse);
                Get.toNamed(Routes.couponDetail);
              },
              child: Column(children: [
                SizedBox(height: 15),
                TicketBox(
                  fromEdgeMain: 62,
                  fromEdgeSeparator: 134,
                  isOvalSeparator: false,
                  smallClipRadius: 15,
                  clipRadius: 25,
                  numberOfSmallClips: 8,
                  ticketWidth: 340,
                  ticketHeight: 130,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              child: Image.network(
                                coupon.imageUrl ?? '',
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                screenSize.height * 0.8 ~/ (10 + 5),
                                (_) => Container(
                                  width: 2,
                                  height: 2,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  coupon.name ?? 'Name not set',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coupon.description ?? 'Description not set',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      coupon.code ?? 'Name not set',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('  Xem chi tiết',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 15)),
                                  ],
                                ),
                                Text(
                                  'Ngày hết hạn: ${Formatter.date(couponInUse.applyDate)}',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
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
            var coupon = couponInUse.coupon!;
            return GestureDetector(
              onTap: () {
                controller.sharedData.saveCouponInUse(couponInUse);
                Get.toNamed(Routes.couponDetail);
              },
              child: Column(children: [
                SizedBox(height: 15),
                TicketBox(
                  fromEdgeMain: 62,
                  fromEdgeSeparator: 134,
                  isOvalSeparator: false,
                  smallClipRadius: 15,
                  clipRadius: 25,
                  numberOfSmallClips: 8,
                  ticketWidth: 340,
                  ticketHeight: 130,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              child: Image.network(
                                coupon.imageUrl ?? '',
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                screenSize.height * 0.8 ~/ (10 + 5),
                                (_) => Container(
                                  width: 2,
                                  height: 2,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  coupon.name ?? 'Name not set',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coupon.description ?? 'Description not set',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                Row(
                                  children: [
                                    Text(coupon.code ?? 'Code not set',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text('  Xem chi tiết',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 15)),
                                  ],
                                ),
                                Text(
                                  'Ngày sử dụng: ${Formatter.date(couponInUse.applyDate)}',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
