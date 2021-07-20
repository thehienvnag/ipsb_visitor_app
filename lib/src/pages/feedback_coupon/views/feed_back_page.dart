import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/feedback_coupon/controllers/feedback_conpon_controller.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/widgets/rounded_button.dart';


class FeedbackCouponPage extends GetView<FeedbackCouponController> {
  // final SharedStates sharedData = Get.find();
  double? rating ;
  String? feedbackContent ;

  @override
  Widget build(BuildContext context) {
    // final couponInuse = sharedData.couponInUse.value;
    Size screenSize = MediaQuery.of(context).size;
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height*0.3,
                color: Color(0xff66CCCC),
              ),
              Container(
                margin: EdgeInsets.only(left: 12,top: 60, right: 12,),
                width: screenSize.width,
                alignment: Alignment.topRight,
                child: RoundedButton(
                  radius: 35,
                  color: Colors.grey.shade50,
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 110, left: 15, right: 15),
                width: screenSize.width,
                height: screenSize.height * 0.67,
                child: Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 20.0,top: 20),
                          child: Center(
                              child: Text(
                                'Đánh giá ưu đãi bạn đã sử dụng',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                          )
                      ),
                      Center(
                          child: Text(
                            'Trải nghiệm về ưu đãi ' +
                                // coupon.coupon!.code.toString() +
                                'như thế nào ?',
                            style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: 10,),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          controller.changeRating(rating);
                        },
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 0.4,
                                ),
                              ),
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  controller.saveFeedback(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.fromLTRB(15, 10, 10, 10),
                                  labelText: 'Phản ánh về ưu đãi/ cửa hàng (nếu có)*',
                                ),
                                maxLines: 4,
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 0.4,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => controller.getImage(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Thêm ảnh  ',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 17,
                                              color: Colors.lightBlueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Card(
                                          color: Colors.grey.shade100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.black.withOpacity(0.6),
                                              size: 25.0,
                                            ),
                                            color: Colors.black,
                                            onPressed: ()=> controller.getImage(),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Obx(() {
                                      String filePath = controller.filePath.value;
                                      if (filePath.isEmpty) {
                                        return Container( height: 120);
                                      } else {
                                        return Container(
                                            child: Card(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.4,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        width: 140, height: 120,
                                                        child: Image.file(File(filePath), fit: BoxFit.cover)
                                                    ),
                                                    Container(
                                                      width: 140, height: 120,
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 4, right: 4),
                                                          child: GestureDetector(
                                                            onTap: () => controller.deleteImage(),
                                                            child: Icon(
                                                              Icons.cancel_outlined,
                                                              color: Colors.red,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            )
                                        );
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                textColor: Color(0xff28BEBA),
                                child: Text(
                                  'GỬI ĐÁNH GIÁ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                color: Colors.white,
                                shape: Border.all(color: Color(0xff28BEBA), width: 2),
                                onPressed: () {
                                  controller.sendFeedback();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}