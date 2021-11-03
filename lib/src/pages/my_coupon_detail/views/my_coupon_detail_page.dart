import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/ticket_box.dart';

class MyCouponDetailPage extends GetView<MyCouponDetailController> {
  final dateTime = DateTime.now();
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("Height: " + screenSize.height.toString() + " , width: " + screenSize.width.toString());

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
                'Coupon Detail',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(height: 20),
            TicketBox(
              xAxisMain: false,
              fromEdgeMain: 500,
              fromEdgeSeparator: 134,
              isOvalSeparator: false,
              smallClipRadius: 15,
              clipRadius: 15,
              numberOfSmallClips: 11,
              ticketWidth: 370,
              ticketHeight: 660,
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
                                  Formatter.shorten(coupon.store?.name,12).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                // if (coupon.discountType! == 'Fixed')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '[Fix] ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          Formatter.price(coupon.amount).toUpperCase(),
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
                            ListItemModel(label: "Promotion: ", data: [ListItemModel(label: "${coupon.name}")]),
                            ListItemModel(label: "Apply with: ", data: [
                              ListItemModel(label: "Full menu (does not apply combos)"),
                              ListItemModel(label: "Price does not include VAT"),
                            ]),
                            ListItemModel(
                              label: "Note: ",
                              data: [
                                ListItemModel(label: "Use in-store only",),
                                ListItemModel(label: "Only 1 promotion can be used when paying"),
                                ListItemModel(label: "Applies to multiple products in the same bill"),
                                // ListItemModel(label: 'View More')
                              ],
                            ),
                          ],
                          textStyle: TextStyle(color: Colors.black54, fontSize: 16),
                          bulletColor: Colors.grey,
                          bulletSize: 3,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon(Icons.more_horiz_outlined,size: 20,color: Colors.blue,),
                          SizedBox(width: 8,),
                          GestureDetector(
                              onTap: (){
                                //CASE 1:
                                // showDetailBottomSheet(coupon, context);
                                //CASE 2:
                                showCustomDialog(context,coupon);
                              },
                              child: Text('View More', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),)),
                          SizedBox(width: 40,),
                        ],
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
                          textStyle: TextStyle(color: Colors.black54, fontSize: 16),
                          bulletColor: Colors.grey,
                          bulletSize: 3,
                          data: [
                            ListItemModel(
                              label: "Apply time: ",
                              data: [
                                ListItemModel(
                                  label: "[${Formatter.date(coupon.publishDate)}]     ----     [${Formatter.date(coupon.expireDate)}]",
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
                              children: _couponState(context, coupon.id, couponInUse, coupon.limit!),
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

  List<Widget> _couponState(BuildContext context, int? couponId, CouponInUse couponInUse, int limit) {
    final screenSize = MediaQuery.of(context).size;
    int state = controller.checkCouponState();
    if (state == 2 || state == 3)
      return [
        if (state == 3)
          ElevatedButton.icon(
            onPressed: () => controller.gotoShowQR(),
            icon: Icon(Icons.qr_code),
            label: Text('Apply now'),
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
                        Text('  Feedbacked'),
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
        onPressed: () => controller.saveCouponInUse(context, couponId, limit),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text('SAVE'),
        ),
      ),
    ];
  }
}

void showCustomDialog(BuildContext context,Coupon coupon) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.0164),
            Text('${coupon.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: screenSize.height * 0.027),
            Container(
              color: Color(0xfffafafa),
              padding: EdgeInsets.only(left: screenSize.width*0.08,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: screenSize.width*0.4,child: Text("Limit: ")),
                  Text("${coupon.limit ?? "N/A"}")
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: screenSize.width*0.08,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: screenSize.width*0.4,child: Text("Min. spend: ")),
                  Text("${Formatter.price(coupon.minSpend ?? 0).toUpperCase()}")
                ],
              ),
            ),
            Container(
              color: Color(0xfffafafa),
              padding: EdgeInsets.only(left: screenSize.width*0.08,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: screenSize.width*0.4,child: Text("Max. discount: ")),
                  Text("${Formatter.price(coupon.maxDiscount ?? 0).toUpperCase()}")
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.0164),
            TextButton(
              child: Text('Close', style: TextStyle(fontSize: 15,)),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  },
);
