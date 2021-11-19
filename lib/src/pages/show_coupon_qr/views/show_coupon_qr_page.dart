import 'package:flutter/material.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/show_coupon_qr/controllers/show_coupon_qr_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
              width: screenSize.width*0.705,
              child: Text(
                'QR CODE',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 9, left: 18, right: 18),
              width: screenSize.width,
              child: Card(
                color: Colors.white,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(coupon.store!.name ?? "Adidas",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      QrImage(
                        data: controller.genCode(coupon, couponInUse.id),
                        size: screenSize.width*0.6,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Give this code to the staff scans',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
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
                  // physics: ScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 5, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: FlutterBulletList(
                          data: [
                            ListItemModel(
                                label: "Promotion: ",
                                data: [ListItemModel(label: "${coupon.name}")]),
                            ListItemModel(label: "Apply for: ", data: [
                              ListItemModel(label: "Full menu (does not apply combos)"),
                              ListItemModel(label: "Price does not include VAT"),
                            ]),
                            ListItemModel(
                              label: "Note: ",
                              data: [
                                // ListItemModel(
                                //   label: "Apply at store only",
                                // ),
                                ListItemModel(
                                    label:
                                        "When paying, only 1 code can be applied"),
                                ListItemModel(
                                    label:
                                        "Applies to multiple products in the same invoice"),
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
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   child: Row(
                            //     children: [
                            //       Icon(Icons.directions, color: Colors.white),
                            //       Text('Direction'),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              width: 6,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                launch("tel://${coupon.store!.phone ?? 0931182303}");
                                },
                              label: Row(
                                children: [
                                  Text('Call store'),
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
