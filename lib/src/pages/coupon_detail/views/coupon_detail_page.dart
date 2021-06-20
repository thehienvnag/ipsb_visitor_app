import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/controllers/coupon_detail_controller.dart';
import 'package:ticketview/ticketview.dart';

class CouponDetailPage extends GetView<CouponDetailController> {
  final Coupon? coupon;

  const CouponDetailPage(this.coupon);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 29,right: 29, bottom: 10),
              child: TicketView(
                backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                drawArc: true,
                triangleAxis: Axis.vertical,
                borderRadius: 1,
                drawDivider: true,
                trianglePos: .8,
                dividerStrokeWidth: 2,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: screenSize.width,
                      height: screenSize.height *0.66,
                      padding: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  width: screenSize.width * 0.3,
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
                                          fontSize: 17,
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
                              SizedBox(height: 20),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      height: 25,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Text(
                              "Thời gian áp dụng: ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Text(
                            coupon!.publishDate.toString() + "  -  " + coupon!.expireDate.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      // Container(
      //   color: Colors.white,
      //   width: screenSize.width,
      //   padding: EdgeInsets.all(18),
      //   height: screenSize.height * 0.9,
      //   child: Card(
      //     elevation: 0,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       side: BorderSide(
      //         color: Colors.grey,
      //         width: 0.5,
      //       ),
      //     ),
      //     child: Column(
      //       children: [
      //         Container(
      //           child: Row(
      //             children: [
      //               Container(
      //                 margin: EdgeInsets.only(left: 40, top: 20),
      //                 width: screenSize.width * 0.3,
      //                 height: 140,
      //                 decoration: BoxDecoration(
      //                   border: Border.all(
      //                       width: 4,
      //                       color: Theme.of(context).scaffoldBackgroundColor),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         spreadRadius: 2,
      //                         blurRadius: 10,
      //                         color: Colors.black.withOpacity(0.1),
      //                         offset: Offset(0, 10))
      //                   ],
      //                   shape: BoxShape.circle,
      //                   image: DecorationImage(
      //                       fit: BoxFit.cover,
      //                       image: NetworkImage(coupon!.imageUrl.toString())),
      //                 ),
      //               ),
      //               Container(
      //                 width: screenSize.width * 0.5,
      //                 child: Column(
      //                   children: [
      //                     Container(
      //                       width: screenSize.width * 0.4,
      //                       margin: EdgeInsets.only(bottom: 5),
      //                       child: Text(
      //                         coupon!.name.toString(),
      //                         style: TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.black.withOpacity(0.7),
      //                         ),
      //                       ),
      //                     ),
      //                     Text(
      //                       coupon!.code.toString(),
      //                       style: TextStyle(
      //                         fontSize: 17,
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.only(top: 40, bottom: 20),
      //           child: Text(coupon!.description.toString(),
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black.withOpacity(0.7))),
      //         ),
      //         Column(
      //           children: [
      //             Text(
      //               "Áp dụng cho: ",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black.withOpacity(0.7)),
      //             ),
      //             Container(
      //               margin: EdgeInsets.only(left: 50, top: 10),
      //               width: screenSize.width * 0.9,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Toàn menu (không áp dụng combo) ",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Giá chưa bao gồm VAT ",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Chỉ áp dụng tại cửa hàng",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Khi thanh toán chỉ áp dụng duy nhất 1 mã (bao gồm khách lẻ và đi theo nhóm)",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Áp dụng cho nhiều sản phẩm trong cùng hóa đơn",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Mỗi người chỉ áp dụng 1 thiết bị chứa mã",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "- Không áp dụng hình chụp màn hình và dùng chung với các chương trình khuyến mãi khác",
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             SizedBox(height: 80),
      //             // Container(
      //             //   child: Row(
      //             //     mainAxisSize: MainAxisSize.min,
      //             //     children: List.generate(
      //             //       screenSize.width*0.8 ~/ (10 + 5),
      //             //           (_) =>
      //             // Container(
      //             //         width: 10,
      //             //         height: 2,
      //             //         color:  Colors.black38,
      //             //         margin: EdgeInsets.only(left: 5 / 2, right: 5 / 2),
      //             //       ),
      //             //     ),
      //             //   ),
      //             // ),
      //             SizedBox(height: 20),
      //             Container(
      //               height: 25,
      //               child: Row(
      //                 children: [
      //                   Container(
      //                     margin: EdgeInsets.only(left: 25),
      //                     child: Text(
      //                       "Thời gian áp dụng: ",
      //                       style: TextStyle(
      //                           fontSize: 18,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.black.withOpacity(0.7)),
      //                     ),
      //                   ),
      //                   Text(
      //                     coupon!.publishDate.toString() +
      //                         "  -  " +
      //                         coupon!.expireDate.toString(),
      //                     style: TextStyle(fontSize: 18),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: Container(
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
            'Lấy ưu đãi',
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
                    "Bạn có muốn lưu mã khuyến mãi không?",
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
      ),
    );
  }
}
