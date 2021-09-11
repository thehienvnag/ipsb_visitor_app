import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';

import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:indoor_positioning_visitor/src/widgets/user_welcome.dart';

class MyCouponDetailPage extends GetView<MyCouponDetailController> {
  final dateTime = DateTime.now();
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      final couponInUse = controller.couponInUse.value;
      final coupon = couponInUse.coupon ?? sharedData.coupon.value;
      if (coupon.id == null) {
        return Scaffold(
          body: Center(
            child: Text('Loading'),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          title: Column(
            children: [
              Text(
                'Chi tiết mã giảm giá',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(height: 40),
            TicketBox(
              xAxisMain: false,
              fromEdgeMain: 470,
              fromEdgeSeparator: 134,
              isOvalSeparator: false,
              smallClipRadius: 15,
              clipRadius: 15,
              numberOfSmallClips: 8,
              ticketWidth: 370,
              ticketHeight: 640,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Card(
                                child: Container(
                                  width: 125,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(coupon.imageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Formatter.shorten(coupon.store?.name)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                if (coupon.discountType! == 'Fixed')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '[Giảm giá] ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          Formatter.price(coupon.amount)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          Formatter.shorten(
                                              '(${coupon.description})'),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 380,
                        child: FlutterBulletList(
                          data: [
                            ListItemModel(
                                label: "Chương trình: ",
                                data: [ListItemModel(label: "${coupon.name}")]),
                            ListItemModel(label: "Áp dụng cho: ", data: [
                              ListItemModel(
                                  label: "Toàn menu (không áp dụng combo)"),
                              ListItemModel(label: "Giá chưa bao gồm VAT}"),
                            ]),
                            ListItemModel(
                              label: "Lưu ý: ",
                              data: [
                                ListItemModel(
                                  label: "Chỉ áp dụng tại cửa hàng",
                                ),
                                ListItemModel(
                                    label:
                                        "Khi thanh toán chỉ áp dụng duy nhất 1 mã"),
                                ListItemModel(
                                    label:
                                        "Áp dụng cho nhiều sản phẩm trong cùng hóa đơn"),
                              ],
                            ),
                          ],
                          textStyle:
                              TextStyle(color: Colors.black54, fontSize: 16),
                          bulletColor: Colors.grey,
                          bulletSize: 3,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlutterBulletList(
                          textStyle:
                              TextStyle(color: Colors.black54, fontSize: 16),
                          bulletColor: Colors.grey,
                          bulletSize: 3,
                          data: [
                            ListItemModel(
                              label: "Thời gian áp dụng: ",
                              data: [
                                ListItemModel(
                                  label:
                                      "[${Formatter.date(coupon.publishDate)}]     ----     [${Formatter.date(coupon.expireDate)}]",
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (!controller.isLoading.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _couponState(coupon.id, couponInUse),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    });
  }

  List<Widget> _couponState(int? couponId, CouponInUse couponInUse) {
    int state = controller.checkCouponState();
    if (state == 2 || state == 3)
      return [
        if (state == 3)
          ElevatedButton.icon(
            onPressed: () => controller.gotoShowQR(),
            icon: Icon(Icons.qr_code),
            label: Text('SỬ DỤNG'),
          ),
        if (state == 2)
          couponInUse.feedbackContent == null
              ? Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      sharedData.couponInUse.value = couponInUse;
                      Get.toNamed(Routes.feedbackCoupon);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.library_add_check_rounded,
                            color: Colors.white),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text('Give feedback'),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                    ),
                    onPressed: () {
                      // sharedData.couponInUse.value = couponInUse;
                      // Get.toNamed(Routes.feedbackCoupon);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.library_add_check_rounded,
                            color: Colors.white),
                        Text('  Đã feedback'),
                      ],
                    ),
                  ),
                ),
        SvgPicture.asset(
          state == 3 ? ConstImg.couponSaved : ConstImg.couponExpired,
          semanticsLabel: 'Acme Logo',
          width: 70,
          height: 70,
        ),
      ];
    return [
      Container(),
      ElevatedButton(
        onPressed: () => controller.saveCouponInUse(couponId),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text('LƯU'),
        ),
      ),
    ];
  }
}
