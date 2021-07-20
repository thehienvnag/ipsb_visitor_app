import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/controllers/show_coupon_qr_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowCouponQRPage extends GetView<ShowCouponQRController> {
  final SharedStates sharedData = Get.find();
  @override
  Widget build(BuildContext context) {
    final couponInUse = sharedData.couponInUse.value;
    final coupon = couponInUse.coupon!;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFEFEBEB),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 290,
              child: Text(
                'MÃ QR CODE',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 9, left: 18, right: 18),
            width: screenSize.width,
            child: Card(
              color: Colors.white,
              child: Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HIGH LAND COFFEE',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${coupon.description})',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      QrImage(
                        data: controller.genCode(coupon, couponInUse.id),
                        size: 220,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Đưa mã này cho nhân viên quét để kích hoạt',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, right: 18),
            width: screenSize.width,
            child: Card(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 5, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                                      "Khi thanh toán chỉ áp dụng duy nhất 1 mã (bao gồm khách đi lẻ và đi theo nhóm"),
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
                      Container(
                        width: screenSize.width * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.directions, color: Colors.white),
                                  Text('Chỉ đường'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              label: Row(
                                children: [
                                  Text('Gọi cửa hàng'),
                                ],
                              ),
                              icon: Icon(Icons.phone),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }


  Widget buildTextField(BuildContext context) => TextField(
        //controller: controller,
        style: TextStyle(
          color: Colors.black26,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
}
