import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/controllers/show_coupon_qr_controller.dart';
import 'package:indoor_positioning_visitor/src/services/shared_data/shared_data.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowCouponQRPage extends GetView<ShowCouponQRController> {
  final SharedData sharedData = Get.find();
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
            Icons.arrow_back_ios,
            color: Colors.black,
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
                coupon.name ?? 'Name not set',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Icon(
              Icons.view_headline,
              color: Colors.black,
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
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Giảm 30k cho đơn từ 100k',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      QrImage(
                        data: coupon.code.toString(),
                        size: 180,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Đưa mã này cho nhân viên quét để kích hoặt',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                padding:
                    EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Thời gian áp dụng: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          Formatter.dateFormat(coupon.publishDate),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Chương trình: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(coupon.code ?? 'Code not set')
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Áp dụng cho: ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                    Container(
                      width: screenSize.width * 0.65,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    color: Colors.white),
                                Text('Chỉ đường'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.phone, color: Colors.white),
                                Text('Gọi cửa hàng'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // <-- Button color
                            ),
                          ),
                        ],
                      ),
                    )
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
