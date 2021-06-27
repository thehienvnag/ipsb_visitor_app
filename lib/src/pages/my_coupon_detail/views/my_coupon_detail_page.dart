import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
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
        backgroundColor: Color(0xFFEFEBEB),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
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
        body: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(children: [
            SizedBox(height: 10),
            TicketBox(
              fromEdgeMain: 464,
              fromEdgeSeparator: 134,
              isOvalSeparator: false,
              smallClipRadius: 15,
              clipRadius: 20,
              numberOfSmallClips: 8,
              ticketWidth: 350,
              ticketHeight: 660,
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  color: Colors.white,
                  width: screenSize.width,
                  height: screenSize.height * 0.7,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: screenSize.width * 0.27,
                              height: 140,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    coupon.imageUrl ?? '',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenSize.width * 0.45,
                              child: Column(
                                children: [
                                  Container(
                                    width: screenSize.width * 0.5,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      coupon.name ?? 'Name not set',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    coupon.code ?? 'Code not set',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.lightGreen,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        //margin: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(coupon.description ?? 'Description not set',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "* Áp dụng cho: ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Áp dụng cho toàn sản phẩm size L ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Toàn menu (không áp dụng combo) ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Áp dụng nhiều sản phẩm trong 1 hóa đơn",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "* Lưu ý: ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Giá chưa bao gồm VAT ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Không đồng thời áp dụng việc tích điểm ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text("Mỗi người chỉ áp dụng 1 thiết bị chứa mã",
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text('Không dùng chung với khuyến mãi khác',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Chỉ áp dụng tại cửa hàng",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Khi thanh toán chỉ áp dụng 1 mã",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.api_sharp,
                                size: 15,
                                color: Colors.lightBlue,
                              ),
                              Text("Không áp dụng hình chụp màn hình",
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              screenSize.width * 0.75 ~/ (10 + 5),
                                  (_) => Container(
                                width: 10,
                                height: 2,
                                color: Colors.black38,
                                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Ngày áp dụng mã : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                              Text(
                                Formatter.date(coupon.publishDate),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Ngày hết hạn : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                              Text(
                                Formatter.date(coupon.expireDate),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                            child: couponInUse.applyDate == null
                                ? SizedBox()
                                : Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: Text(
                                    "Ngày sử dụng : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                ),
                                Text(
                                  Formatter.date(couponInUse.applyDate), style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          sharedData.coupon.value.id == null && coupon.id != null
                              ? SizedBox()
                              : Container(
                            margin: EdgeInsets.only(left: 20, right: 30, bottom: 40),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 38,
                                child: FloatingActionButton.extended(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                            ),
                            backgroundColor: Colors.lightBlue,
                            label: Text(
                                'Lấy ưu đãi',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white, letterSpacing: 4),
                            ),
                            onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        "Bạn có muốn lưu mã khuyến mãi không?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.createCouponInUse(coupon.id!);

                                          },
                                          child: Text('Lưu ngay'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                            },
                          ),
                              )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: (controller.checkCouponValid('NotUse', couponInUse))
            ? Container(
          margin: EdgeInsets.only(right: 50, bottom: 40),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 38,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            backgroundColor: Colors.lightBlue,
            label: Text(
              'Dùng ngay',
              style: TextStyle(
                  fontSize: 17, color: Colors.white, letterSpacing: 4),
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      "Bạn có muốn dùng mã khuyến mãi không?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Không'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.showCouponQR);
                        },
                        child: Text('Áp dụng'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        )
            : SizedBox());
  }
}
