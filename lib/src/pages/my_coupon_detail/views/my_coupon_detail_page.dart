import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
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
import 'package:readmore/readmore.dart';

class MyCouponDetailPage extends GetView<MyCouponDetailController> {
  final dateTime = DateTime.now();
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      final couponInUse = controller.couponInUse.value;
      final coupon = couponInUse.coupon ?? sharedData.coupon.value;
      if (coupon.id == null || controller.isLoading.isTrue) {
        return Scaffold(
          body: Center(
            child: Container(
              child: CircularProgressIndicator(),
              height: 30,
              width: 30,
            ),
          ),
        );
      }
      if (coupon.id == null && controller.isLoading.isFalse) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: screenSize.height * 0.258,
                width: screenSize.width * 0.486,
                child: Image.asset(ConstImg.error),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Oops! Can not load coupon',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: screenSize.width * 0.778,
                child: Text(
                  'Coupon may have been removed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
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
          child: SingleChildScrollView(
            child: Column(children: [
              TicketBox(
                xAxisMain: false,
                fromEdgeMain: screenSize.height * 0.645,
                fromEdgeSeparator: 134,
                isOvalSeparator: false,
                smallClipRadius: 15,
                clipRadius: 15,
                numberOfSmallClips: 11,
                ticketWidth: screenSize.width * 0.9,
                ticketHeight: screenSize.height * 0.85,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: screenSize.width * 0.9,
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Card(
                                      child: Container(
                                        width: screenSize.width * 0.283,
                                        height: screenSize.height * 0.129,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              coupon.imageUrl!,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Formatter.shorten(
                                                coupon.store?.name, 12)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      // if (coupon.discountType! == 'Fixed')
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 8),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              width: screenSize.width * 0.9,
                              child: FlutterBulletList(
                                data: [
                                  ListItemModel(
                                    label: "Promotion: ",
                                    data: [
                                      ListItemModel(label: "${coupon.name}"),
                                    ],
                                  ),
                                  ListItemModel(
                                    label: "Note: ",
                                    data: [
                                      ListItemModel(
                                        label:
                                            'Have your coupon ready before purchasing services.',
                                      ),
                                      ListItemModel(
                                        label:
                                            'Only one coupon is applied to a specific order.',
                                      ),
                                      ListItemModel(
                                        label:
                                            'Coupon will be usable unless limit usage has been reached.',
                                      ),
                                    ],
                                  ),
                                  ListItemModel(label: "Description: "),
                                ],
                                textStyle: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                                bulletColor: Colors.grey,
                                bulletSize: 3,
                              ),
                            ),
                            Container(
                              width: screenSize.width * 0.9,
                              margin: const EdgeInsets.only(left: 45),
                              child: ReadMoreText(
                                '○  ${coupon.description}',
                                trimLines: 2,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                                colorClickableText: Colors.blueAccent,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: screenSize.height * 0.1935,
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterBulletList(
                                textStyle: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                                bulletColor: Colors.grey,
                                bulletSize: 3,
                                data: [
                                  ListItemModel(
                                    label: "Apply time: ",
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: _couponState(
                                      context,
                                      coupon,
                                      couponInUse,
                                      coupon.limit!,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        onPressed: () => showCustomDialog(context, coupon),
                        icon: Icon(Icons.info),
                        color: Colors.blueAccent,
                        iconSize: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }

  List<Widget> _couponState(
    BuildContext context,
    Coupon coupon,
    CouponInUse couponInUse,
    int limit,
  ) {
    // final screenSize = MediaQuery.of(context).size;
    const double iconSize = 75;
    if (coupon.overLimit != null &&
        coupon.overLimit! &&
        (couponInUse.id == null || couponInUse.status == "NotUsed")) {
      return [
        Container(),
        Image.asset(
          ConstImg.couponOverLimit,
          width: iconSize,
          height: iconSize,
        ),
      ];
    }
    if (couponInUse.status == "NotUsed" &&
        coupon.status == "Active" &&
        coupon.expireDate!.compareTo(DateTime.now()) > 0) {
      return [
        ElevatedButton.icon(
          onPressed: () => controller.gotoShowQR(),
          icon: Icon(Icons.qr_code),
          label: Text('Apply now'),
        ),
        Image.asset(
          ConstImg.couponSaved,
          width: iconSize,
          height: iconSize,
        ),
      ];
    } else if (couponInUse.status == "Used") {
      return [
        if (couponInUse.rateScore == null)
          ElevatedButton(
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
                Icon(Icons.library_add_check_rounded, color: Colors.white),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text('Give feedback'),
                ),
              ],
            ),
          ),
        if (couponInUse.rateScore != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen,
            ),
            onPressed: () {
              // sharedData.couponInUse.value = couponInUse;
              // Get.toNamed(Routes.feedbackCoupon);
            },
            child: Row(
              children: [
                Icon(Icons.library_add_check_rounded, color: Colors.white),
                Text('  Feedbacked'),
              ],
            ),
          ),
        Image.asset(
          ConstImg.couponUsed,
          width: iconSize,
          height: iconSize,
        ),
      ];
    }
    if (coupon.status == "Inactive") {
      return [
        Container(),
        Image.asset(
          ConstImg.couponDeleted,
          width: iconSize,
          height: iconSize,
        ),
      ];
    } else if (coupon.expireDate!.compareTo(DateTime.now()) < 0) {
      return [
        Container(),
        Image.asset(
          ConstImg.couponExpired,
          width: iconSize,
          height: iconSize,
        ),
      ];
    }
    return [
      Container(),
      ElevatedButton(
        onPressed: () => controller.saveCouponInUse(context, coupon.id, limit),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text('SAVE'),
        ),
      ),
    ];
  }
}

void showCustomDialog(BuildContext context, Coupon coupon) => showDialog(
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
                Text(
                  '${coupon.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: screenSize.height * 0.027),
                Container(
                  color: Color(0xfffafafa),
                  padding:
                      EdgeInsets.only(left: screenSize.width * 0.08, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: screenSize.width * 0.4,
                          child: Text("Limit: ")),
                      Text("${coupon.limit ?? "N/A"}")
                    ],
                  ),
                ),
                if (coupon.minSpend != null)
                  Container(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.08, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: screenSize.width * 0.4,
                            child: Text("Min. spend: ")),
                        Text(
                            "${Formatter.price(coupon.minSpend).toUpperCase()}")
                      ],
                    ),
                  ),
                if (coupon.maxDiscount != null)
                  Container(
                    color: Color(0xfffafafa),
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.08, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: screenSize.width * 0.4,
                            child: Text("Max. discount: ")),
                        Text(
                            "${Formatter.price(coupon.maxDiscount ?? 0).toUpperCase()}")
                      ],
                    ),
                  ),
                SizedBox(height: screenSize.height * 0.0164),
                TextButton(
                  child: Text('Close',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },
    );
