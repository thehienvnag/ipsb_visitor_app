import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponDetailPage extends GetView<MyCouponController> {
  final CouponInUse? coupon;

  const MyCouponDetailPage(this.coupon);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            Navigator.pop(context);
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
      body:  Container(
        margin: EdgeInsets.only( left: 30, right: 30),
        child: Column(
            children: [
              SizedBox(height: 15),
              FlutterTicketWidget(
                width: screenSize.width,
                height: screenSize.height*0.86,
                isCornerRounded: true,
                child: Padding(
                  padding: EdgeInsets.only( left: 25, right: 25),
                  child:  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        width: screenSize.width,
                        height: screenSize.height *0.64,
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
                                          image: NetworkImage(coupon!.imageUrl.toString())),
                                    ),
                                  ),
                                  Container(
                                    width: screenSize.width * 0.45,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: screenSize.width * 0.4,
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            coupon!.name.toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          coupon!.code.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.lightGreen
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30, bottom: 20),
                              child: Text(coupon!.description.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7))),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Áp dụng cho: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  width: screenSize.width * 0.9,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Toàn menu (không áp dụng combo) ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Giá chưa bao gồm VAT ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Chỉ áp dụng tại cửa hàng",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Khi thanh toán chỉ áp dụng duy nhất 1 mã (bao gồm khách lẻ và đi theo nhóm)",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Áp dụng cho nhiều sản phẩm trong cùng hóa đơn",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Mỗi người chỉ áp dụng 1 thiết bị chứa mã",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "- Không áp dụng hình chụp màn hình và dùng chung với các chương trình khuyến mãi khác",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      screenSize.width*0.75 ~/ (10 + 5),
                                          (_) =>
                                          Container(
                                            width: 10,
                                            height: 2,
                                            color:  Colors.black38,
                                            margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
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
                              coupon!.publishDate.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Text(
                                "Ngày hết hạn mã : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                            ),
                            Text(
                              coupon!.expireDate.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        child: coupon!.applyDate.toString().endsWith('null') ?
                        SizedBox() : Row(
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
                              coupon!.applyDate.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
      floatingActionButton:
      (coupon!.status == "NotUse") ? Container(
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
                    style:
                    TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 4),
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
                            FlatButton(
                              textColor: Color(0xFF6200EE),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Không'),
                            ),
                            FlatButton(
                              textColor: Color(0xFF6200EE),
                              onPressed: () {
                                // code here
                              },
                              child: Text('Lưu ngay'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ): SizedBox()
    );
  }
}
