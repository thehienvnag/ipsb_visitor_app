import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';

import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/utils/utils.dart';
import 'package:indoor_positioning_visitor/src/widgets/rounded_button.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';

class MyCouponDetailPage extends GetView<MyCouponDetailController> {
  final dateTime = DateTime.now();
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final couponInUse = sharedData.couponInUse.value;
    final coupon = couponInUse.coupon ?? sharedData.coupon.value;
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
            fromEdgeMain: 545,
            fromEdgeSeparator: 134,
            isOvalSeparator: false,
            smallClipRadius: 15,
            clipRadius: 17,
            numberOfSmallClips: 8,
            ticketWidth: 370,
            ticketHeight: 640,
            child: Column(
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
                            Formatter.shorten(coupon.store?.name).toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          if (coupon.discountType! == 'Fixed')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Colors.black54, fontSize: 16),
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
                        label: "Thời gian áp dụng:",
                        data: [
                          ListItemModel(
                              label:
                                  "${Formatter.date(coupon.publishDate)}  -  ${Formatter.date(coupon.expireDate)}"),
                        ],
                      ),
                      ListItemModel(
                          label: "Chương trình: ",
                          data: [ListItemModel(label: "${coupon.name}")]),
                      ListItemModel(label: "Áp dụng cho: ", data: [
                        ListItemModel(label: "Toàn menu (không áp dụng combo)"),
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
                                  "Khi thanh toán chỉ áp dụng duy nhất 1 mã (bao gồm khách đi lẻ và đi theo nhóm"),
                          ListItemModel(
                              label:
                                  "Áp dụng cho nhiều sản phẩm trong cùng hóa đơn"),
                        ],
                      ),
                    ],
                    textStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    bulletColor: Colors.grey,
                    bulletSize: 3,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedButton(
                        onPressed: () {},
                        radius: 40,
                        icon: Icon(Icons.ios_share_outlined),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.save),
                        label: Text('Lấy ưu đãi'),
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
    // floatingActionButton:
    //     (controller.checkCouponValid('NotUse', couponInUse))
    //         ? Container(
    //             margin: EdgeInsets.only(right: 50, bottom: 40),
    //             width: MediaQuery.of(context).size.width * 0.7,
    //             height: 38,
    //             child: (sharedData.coupon.value.name == null)
    //                 ? FloatingActionButton.extended(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(10.0),
    //                       ),
    //                     ),
    //                     backgroundColor: Colors.lightBlue,
    //                     label: Text(
    //                       'Dùng ngay',
    //                       style: TextStyle(
    //                           fontSize: 17,
    //                           color: Colors.white,
    //                           letterSpacing: 4),
    //                     ),
    //                     onPressed: () {
    //                       showDialog(
    //                         context: context,
    //                         barrierDismissible: false,
    //                         builder: (context) {
    //                           return AlertDialog(
    //                             content: Text(
    //                               "Bạn có muốn dùng mã khuyến mãi không?",
    //                             ),
    //                             actions: [
    //                               TextButton(
    //                                 onPressed: () {
    //                                   Navigator.of(context).pop();
    //                                 },
    //                                 child: Text('Không'),
    //                               ),
    //                               TextButton(
    //                                 onPressed: () {
    //                                   Get.toNamed(Routes.showCouponQR);
    //                                 },
    //                                 child: Text('Áp dụng'),
    //                               ),
    //                             ],
    //                           );
    //                         },
    //                       );
    //                     },
    //                   )
    //                 : FloatingActionButton.extended(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(10.0),
    //                       ),
    //                     ),
    //                     backgroundColor: Colors.lightBlue,
    //                     label: Text(
    //                       'Lấy ưu đãi',
    //                       style: TextStyle(
    //                           fontSize: 17,
    //                           color: Colors.white,
    //                           letterSpacing: 4),
    //                     ),
    //                     onPressed: () {
    //                       showDialog(
    //                         context: context,
    //                         barrierDismissible: false,
    //                         builder: (context) {
    //                           return AlertDialog(
    //                             content: Text(
    //                               "Bạn có muốn lưu mã khuyến mãi không?",
    //                             ),
    //                             actions: [
    //                               TextButton(
    //                                 onPressed: () {
    //                                   Navigator.of(context).pop();
    //                                 },
    //                                 child: Text('Không'),
    //                               ),
    //                               TextButton(
    //                                 onPressed: () {
    //                                   Get.toNamed(Routes.showCouponQR);
    //                                 },
    //                                 child: Text('Lưu ngay'),
    //                               ),
    //                             ],
    //                           );
    //                         },
    //                       );
    //                     },
    //                   ))
    //         : SizedBox());
  }
}
